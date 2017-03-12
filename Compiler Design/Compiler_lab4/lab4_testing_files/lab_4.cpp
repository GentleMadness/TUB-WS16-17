#include <llvm/Pass.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/Instruction.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/InstVisitor.h>
#include <llvm/IR/CFG.h>
#include <llvm/IR/InstIterator.h>
#include <llvm/IR/Constants.h>
#include <llvm/ADT/SmallVector.h>
#include <llvm/ADT/DenseSet.h>
#include <llvm/Support/raw_ostream.h>

#include <map>
#include <string>
#include <vector>
#include <iterator>
#include <algorithm>
#include <utility>

using namespace llvm;
using std::map;
using std::make_pair;
using std::vector;
using std::sort;
using std::string;
using std::to_string;
using std::back_inserter;

using namespace llvm;

namespace {
    
    /* Represents state of a single Value. There are three possibilities:
     *  * undefined: Initial state. Unknown whether constant or not.
     *  * constant: Value is constant (with value C).
     *  * overdefined: Value is not constant. */
    class State {
    public:
        State() : Kind(UNDEFINED), Const(nullptr) { Kind = UNDEFINED; Const = nullptr; }
        
        bool isOverdefined() const { return Kind == OVERDEFINED; }
        bool isUndefined() const { return Kind == UNDEFINED; }
        bool isConstant() const { return Kind == CONSTANT; }
        Constant *getConstant() const {
            assert(isConstant());
            return Const;
        }
        
        void markOverdefined() { Kind = OVERDEFINED; }
        void markUndefined() { Kind = UNDEFINED; }
        void markConstant(Constant *C) {
            Kind = CONSTANT;
            Const = C;
        }
        
        void print(raw_ostream &O) const {
            switch (Kind) {
                case UNDEFINED: O << "undefined"; break;
                case OVERDEFINED: O << "overdefined"; break;
                case CONSTANT: O << "const " << *Const; break;
            }
        }
        
    private:
        enum {
            OVERDEFINED,
            UNDEFINED,
            CONSTANT
        } Kind;
        Constant *Const;
    };
    
    raw_ostream &operator<<(raw_ostream &O, const State &S) {
        S.print(O);
        return O;
    }
    
    class ConstPropPass : public FunctionPass, public InstVisitor<ConstPropPass> {
    public:
        static char ID;
        ConstPropPass() : FunctionPass(ID) {}
        
        virtual void getAnalysisUsage(AnalysisUsage &au) const {
            au.setPreservesAll();
        }
        
        
        virtual bool runOnFunction(Function &F) {
            // TODO Implement constant propagation
            
            /************** Initialize the WorkList (contains instructions that still need to be processed) *************************************/
            
            for(BasicBlock &BB : F) { //The WorkList initially contains all instructions
                for(Instruction &I : BB) {
                    WorkList.push_back(&I);
                }
            }    // or simply use visit(&F);
            
            
            
            /*************** Initial function arguments are alwyas OverDefined ****************/
            for(Argument &a : F.getArgumentList()) {
                State &state = getValueState(&a); //DenseMap<Value *, State> StateMap; getValueState() defined below.
                state.markOverdefined();  // initial arguments are always not constant, they are overdefined.
            }
            /**************** While the WorkList is not empty, begin the propogation from here*****************/
            while (!WorkList.empty()){
           // printResults(F);
                // on each iteration, call the different vist functions below and each time one instruction is removed from the worklist and "visited".
                //When visting an instruction: visit(&I):
                // distinguish between phi-nodes and other instructions in the diffierent visit-functions.
                // *.pop_back_val gives values from the end.
                Instruction *I = dyn_cast<Instruction>(WorkList.back());
                WorkList.pop_back(); //delete the last element
                if (I)
                  visit(I);
            }//End of While
            printResults(F);
            return false;
        }
        
        
        /*   The Second Step, Visit Phi-Nodes instruction
         Visiting Phi-nodes:
         combine states from multiple control-flow paths (in a must relationship)
         1. If any Phi operand is "overdefined" => result= "overdefined"
         2. If there are 2 (or more) Phi operands that are "constant", but have different constant values => result= "overdefined"
         3. If there is 1 (or more) Phi operand that is "constant", and all other "constant" Phi operands have the same constant value C => result= "constant" with value C
         -- They can be also all "undefined" (or a few "undefined" with a few constant), they all just need to have the value C
         (the consatnt ones. if the "undefined" do not have this value -> it will be corrected later on).
         4. If all Phi operands are "undefined" => result= "undefined"
         */
        
        void visitPHINode(PHINode &Phi) {
            // TODO
            SmallVector<Constant *, 64> ConstantList;
            
             State old_state = getValueState(&Phi);
            State &new_state = getValueState(&Phi);
  
           Value *Op;
           
           
           
            for (int i = 0; i < Phi.getNumOperands(); i++){ //getNumOperands() return the total #operands in this phi-node
                Op = Phi.getOperand(i); //get one of the Phi-nodes variables (e.g. a0,a1,a2 in a2= phi(a0,a1))
                //1. If any Phi operand is "overdefined" => result= "overdefined" (and is done for this operand)
                State &s = getValueState(Op);
                
                if (s.isOverdefined()){
                  //  StateMap[Op].markOverdefined();
                    new_state.markOverdefined();
                    return;
                }
                else if (s.isConstant()){
                	ConstantList.push_back(s.getConstant()); // record different constants assigned to one same variable
                }
                    
            } // End of for-loop
            
            
            // Then start from here dealing with constants
            if(ConstantList.size() == 0){  // if all constant operands (for this Phi-node) are undefined then mark this node als undefined (e.g. a2 is undefined if in a2= phi(a0,a1) both states of a0 and a1 are undefined)
               // StateMap[Op].markUndefined();
                new_state.markUndefined();
                return;
            }
            else if(ConstantList.size() == 1){ // if there is only one consatnt operand then make this node als constant with this value in ConstantList[0] (e.g. a2 is consatnt if in a2= phi(a0,b1) the state of a0 is constant)
               // StateMap[Op].markConstant(ConstantList[0]);
                new_state.markConstant(ConstantList[0]);
                return;
            }
            else if(ConstantList.size() >= 2){ // if there is more than one constant that is assigned to the variable, check if it is overdefined (and then mark this node als overdefined) (e.g. a2 is overdefined if in a2= phi(a0,a1) a0 has value c1 and a2 has value c2)
                Constant* new_constant;
                Constant* old_constant;
                for (int i = 1; i< ConstantList.size();i++){
                    old_constant = ConstantList[i-1];
                    new_constant = ConstantList[i];
                    if (new_constant != old_constant){
                       // StateMap[Op].markOverdefined();
                        new_state.markOverdefined();
                        return;
                    }
                } // end of for-loop
               // StateMap[Op].markConstant(ConstantList[0]); // if all the constants in the end have the same consatnt value, mark the node als constant with the "same" value (e.g. a2 is consatnt if in a2= phi(a0,a1) a0 has value c1 and a2 has also the value c1)
                new_state.markConstant(ConstantList[0]);
            } // end of check for a node that is either overdefined or consant if it has the same value in all its assignments.
            
             if (!  ( (old_state.isOverdefined()&& new_state.isOverdefined()) || (old_state.isConstant()&& new_state.isConstant()) ||(old_state.isUndefined() && new_state.isUndefined() )) )
             {
               for (Value *V : Phi.users())
                        WorkList.push_back(V);  // push back loadinstruction to the worklist to check if the value changed   
            }//End of If
            
        } // end of the assigments of the variables in the phi-node and especially the end value of the phi node "main" varaible (e.g. a2 in a2= phi(a0,a1))
        
        
        /*
         The Second Step, Visit other instructions
         Visiting other instructions:
         evaluate instruction at compile-time.
         1. If any of the operands is "overdefined" => result= "overdefined"
         2. If any of the operands is "undefined" => result= "undefined"
         3. If all operands are "consatnt" => evaluate the instruction at compile-time:
         -- if possible => result= "constant"
         -- otherwise: => result= "overdefined"
         */
        void visitBinaryOperator(Instruction &I) {
            // TODO
            // Hint: ConstExpr::get()
            
            State old_state = getValueState(&I);
            State &new_state = getValueState(&I);
            
            if (I.getNumOperands() == 2){ // in the test we only deal with 2 operands at most,
                //if it's single operand, the status depends on the instruction status, e.g status of j++ is the same as j.
                Value *First_Op = I.getOperand(0);
                Value *Second_Op = I.getOperand(1);
                State &s1 = getValueState(First_Op);
                State &s2 = getValueState(Second_Op);
                
                if (s1.isOverdefined() || s2.isOverdefined()){
                 //errs() << "HERE1!!" << "\n  -> " << "\n";
                	//StateMap[&I].markOverdefined();
                	new_state.markOverdefined();
                }
                   
                
                else if (s1.isUndefined() || s2.isUndefined()){
                // errs() << "HERE2!!" << "\n  -> " << "\n";
                	//StateMap[&I].markUndefined();
                	new_state.markUndefined();
                }
                    
                
               else if (s1.isConstant() && s2.isConstant()){
                    Constant *cst;
                    cst = ConstantExpr::get(I.getOpcode(), s1.getConstant(), s2.getConstant());
                    //errs() << "HERE3!!" << "\n  -> " << "\n";
                    if (cst){
                    	// StateMap[&I].markConstant(cst);
                    	 new_state.markConstant(cst);
                    }
                     
                }
                
                else{
                // errs() << "HERE4!!" << "\n  -> " << "\n";
                	//StateMap[&I].markOverdefined();     //default status
                	new_state.markOverdefined();
                }
                    
            }
            
            
            
              if (!  ( (old_state.isOverdefined()&& new_state.isOverdefined()) || (old_state.isConstant()&& new_state.isConstant()) ||(old_state.isUndefined() && new_state.isUndefined() )) )
             {
               // errs() << "We are the same!!" << "\n  -> " << "\n"; //the value of the instruction does not change, check the LoadInst
               for (Value *V : I.users())
                        WorkList.push_back(V);  // push back loadinstruction to the worklist to check if the value changes
                
            }//End of If
        }
        
        void visitCmpInst(CmpInst &I) {
            // TODO
            // Hint: ConstExpr::getCompare()
            
            State old_state = getValueState(&I);
            State &new_state = getValueState(&I);
            
            if (I.getNumOperands() == 2){
                Value *First_Op = I.getOperand(0);
                Value *Second_Op = I.getOperand(1);
                 State &s1 = getValueState(First_Op);
                State &s2 = getValueState(Second_Op);
                
                if (s1.isOverdefined() || s2.isOverdefined()){
                	//StateMap[&I].markOverdefined();
                	new_state.markOverdefined();
                }
                    
                
               else if (s1.isUndefined() || s2.isUndefined()){
                	//StateMap[&I].markUndefined();
                	new_state.markUndefined();
                }
                    
                
               else if (s1.isConstant() && s2.isConstant()){
                    Constant *cst2;
                    cst2 = ConstantExpr::getCompare(I.getPredicate(), s1.getConstant(), s2.getConstant());
                    if(cst2){
                    	//StateMap[&I].markConstant(cst2);
                    	new_state.markConstant(cst2);
                    }
                       
                }
                
                else{
                	//StateMap[&I].markOverdefined();     //default status
                	new_state.markOverdefined();
                }
                    
            }
            
            if (!  ( (old_state.isOverdefined()&& new_state.isOverdefined()) || (old_state.isConstant()&& new_state.isConstant()) ||(old_state.isUndefined() && new_state.isUndefined() )) )
             {
               // errs() << "We are the same!!" << "\n  -> " << "\n"; //the value of the instruction does not change, check the LoadInst
               for (Value *V : I.users())
                        WorkList.push_back(V);  // push back loadinstruction to the worklist to check if the value changes
                
            }//End of If
        }
        
        void visitCastInst(CastInst &I) {// Cast Instruction performs data cast, for example, float f = 1.5, CastInst could be->  int i = f;
            // TODO
            // Hint: ConstExpr::getCast()
            
            State old_state = getValueState(&I);
            State &new_state = getValueState(&I);
            
            
            Value *Org_Op = I.getOperand(0); // operand (0) is the original class operand
            State &s = getValueState(Org_Op);
            
            if (I.getNumOperands() >= 1){
                if (s.isOverdefined()){
                	//StateMap[&I].markOverdefined();
                	new_state.markOverdefined();
                }    
                else if (s.isUndefined()){
                	//StateMap[&I].markUndefined();
                	new_state.markUndefined();
                }
                    
                else if (s.isConstant()){
                    Constant *ret;
                    ret = ConstantExpr::getCast(I.getOpcode(), s.getConstant(), I.getType());
                    if(ret){
                    //	StateMap[&I].markConstant(ret);
                    	new_state.markConstant(ret);
                    }
                      
                }
            }
            
             if (!  ( (old_state.isOverdefined()&& new_state.isOverdefined()) || (old_state.isConstant()&& new_state.isConstant()) ||(old_state.isUndefined() && new_state.isUndefined() )) )
             {
               // errs() << "We are the same!!" << "\n  -> " << "\n"; //the value of the instruction does not change, check the LoadInst
               for (Value *V : I.users())
                        WorkList.push_back(V);  // push back loadinstruction to the worklist to check if the value changes
                
            }//End of If
        }
        
        void visitInstruction(Instruction &I) {
            // TODO Fallback case
            State old_state = getValueState(&I);
            State &new_state = getValueState(&I);
   
            new_state.markOverdefined();
            
            if (!old_state.isOverdefined()){
               // errs() << "We are the same!!" << "\n  -> " << "\n"; //the value of the instruction does not change, check the LoadInst
               for (Value *V : I.users())
                        WorkList.push_back(V);  // push back loadinstruction to the worklist to check if the value changes
                
            }//End of If
        }
        
    private:
        /* Gets the current state of a Value. This method also lazily
         * initializes the state if there is no entry in the StateMap
         * for this Value yet. The initial value is CONSTANT for
         * Constants and UNDEFINED for everything else. */
        State &getValueState(Value *Val) {
            auto It = StateMap.insert({ Val, State() });
            State &S = It.first->second;
            
            if (!It.second) {
                // Already in map, return existing state
                return S;
            }
            
            if (Constant *C = dyn_cast<Constant>(Val)) {
                // Constants are constant...
                S.markConstant(C);
            }
            
            // Everything else is undefined (the default)
            return S;
        }
        
        /* Print the final result of the analysis. */
        void printResults(Function &F) {
            for (BasicBlock &BB : F) {
                for (Instruction &I : BB) {
                    State S = getValueState(&I);
                    errs() << I << "\n    -> " << S << "\n";
                }
            }
        }
        
        // Map from Values to their current State
        DenseMap<Value *, State> StateMap;
        // Worklist of instructions that need to be (re)processed
        SmallVector<Value *, 64> WorkList;
    };
    
}

// Pass registration
char ConstPropPass::ID = 0;
static RegisterPass<ConstPropPass> X("const-prop-pass", "Constant propagation pass");
