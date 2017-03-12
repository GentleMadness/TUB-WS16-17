/* TODO: Algorithm we use: Forward Must Flow Analysis

In forward flow analysis, the exit state of a block is a function of the block's entry state. 
This function (that will be applied on the entry state) is the composition of the effects of the statements in the block.
The entry state of a block is a function of the exit states of its predecessors. 
In a must analysis, we need that all predecessors of a state are "accepting" (basiclly we apply the intersection operator- AND-> is true iff all is true)

Data-flow equations:

For each block b:
    out_b = trans_b(in_b)
    in_b = join_(p∈pred_b) (out_p)
In this, trans_b is the transfer function of the block b. It takes the giving entry inforamtion and adding to it with a generation function. The generation function add a variable (or put it on true- depending on the implementation) to the entry state information (vector of variables in our case).
 It works on the entry state in_b, yielding the exit state out_b.
The join operation combines the exit states of the predecessors p∈ pred_b, yielding the entry state of b.

*/

// Include some headers that might be useful
#include <llvm/Pass.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/Instruction.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/CFG.h>
#include <llvm/IR/InstIterator.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/ValueMap.h>
#include <llvm/ADT/BitVector.h>
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

namespace {

class DefinitionPass : public FunctionPass {
public:
  static char ID;
  DefinitionPass() : FunctionPass(ID) {}

  virtual void getAnalysisUsage(AnalysisUsage &au) const {
    au.setPreservesAll();
  }
    
/******	INTERSECTION ********/
// needed for evaluating the information for the predecessors of an entry-state
vector<string> intersection_vector(vector<string> &v1, vector<string> &v2) { 
	vector<string> IntersectedSet; 
        sort(v1.begin(), v1.end());
	sort(v2.begin(), v2.end());
	set_intersection(v1.begin(), v1.end(), v2.begin(), v2.end(), back_inserter(IntersectedSet));
	return IntersectedSet;// a set of strings that appear in both vector
}

/****** UNION *************/
// needed for adding the new generation information to the entry-state -> the function, that later will be saved in the exit-state of each block
vector<string> union_vector(vector<string> &v1, vector<string> &v2) {
	vector<string> UnionedSet;
    sort(v1.begin(), v1.end());
	sort(v2.begin(), v2.end());	
	set_union(v1.begin(), v1.end(), v2.begin(), v2.end(), back_inserter(UnionedSet));
	return UnionedSet; // a set of all strings appear in two strings, and no dupication
}

/**** fixed-point ******/
// is need for Step 2 of our algorithm: the iteration step: the evaluation of all entry and exit state till the reaching the "fixed-point"
// It means that there is no new information to evaluate
bool fixed_point(map<BasicBlock*, vector<string>> &out, map<BasicBlock*, vector<string>> &new_out, bool flag) {
    
	if (!flag) // for the first BB- flag=false -> If we are in the first BB, we defintly have to evaluate new information
	   return false;
    
	bool eq = false;
    
	for(auto iter = out.begin(); iter != out.end(); ++iter) {
	    eq = false;
            if (out[iter->first].size() <= new_out[iter->first].size())
		  eq = equal (out[iter->first].begin(), out[iter->first].end(), new_out[iter->first].begin());
            if (!eq)
                  break;
	}
	return eq;
}

virtual bool runOnFunction(Function &F) {

        map<BasicBlock*, vector<string>> bb_in_set;    
	map<BasicBlock*, vector<string>> bb_out_set; 
	map<BasicBlock*, vector<string>> bb_gen_set;  
	map<BasicBlock*, vector<string>> new_bb_out_set; // generate for the fix point  

	vector<string> first_bb_temp; //check the first bb, as the input set only depend on the function argument.
	vector<string> in_set;  //the in set of the very first BB
	vector<string> allocate_set; // for AllocaInst
	vector<string> gen_set;  // for StoreInst
	vector<string> insert_temp;
	vector<string> empty_set;

/******************* Get the First Basic Block: first_bb ***********************************************************/
	BasicBlock* first_bb = F.begin(); //get the first basic block memory address

/******************** Put arguments of the Function in in_set and allocate_set ************************************/
	for(Argument &a : F.getArgumentList()) {
	    in_set.push_back(string(a.getName()));  // in_set initialized by the argument list of Function F (for example: void f (int a, float b) then in_set contains (a,b) )
	    allocate_set.push_back(string(a.getName()));  // AllocaInstruct recives the same information as in_set
	}

/*************************************************************************************************
				   Step 1: initialize the in and out sets for each basic block
*************************************************************************************************/

/**************** first basic block's bb_in_set includes the list of arguments that we defined before *********************************/

	bb_in_set.insert(make_pair(first_bb, in_set)); // very first BB has as input all arguments of the function F as an bb_in_set
 
/**************************** From here get into each Basic Block, firstly deal with the allocate_set and bb_gen_set *******************/
	for(BasicBlock &BB : F) {
	    bb_in_set.insert(make_pair(&BB, in_set)); //except first_bb, other BBs are all paired with empty in_set
        
        // clear in, gen and empty sets for new BB in the next iteration
	    in_set.clear();
	    gen_set.clear();
	    empty_set.clear();

	    for(Instruction &I : BB) { //start to deal with each instruction in 1 BB, get into a BB inside
/********************************** allocate_set (Allocate Instruction) ****************************************************************/
	          if(AllocaInst *ai = dyn_cast<AllocaInst>(&I)) { // for AllocaInst within a BB, for example: int c; -> allocate_set=(c)
	              string variable_name = I.getName();
              // if the allocated variable is not already in the allocate_set, add it into the allocate set of this BB
		      if((!variable_name.empty()) && find(allocate_set.begin(), allocate_set.end(),variable_name) == allocate_set.end()) 
			      allocate_set.push_back(variable_name);
		      }
/************************************** bb_gen_set (Store Instruction) *********************************************************************/
		      else if(StoreInst *si = dyn_cast<StoreInst>(&I)) {//StoreInst should be added to gen_set: for example c=5;-> gen_set=(c)
		         string variable_name = I.getOperand(1)->getName(); // position 1, assembly language
                  // if the now defined variable is not already in gen set, add it into the generaion set of this BB
		         if((!variable_name.empty()) && find(gen_set.begin(), gen_set.end(), variable_name) == gen_set.end())
			        gen_set.push_back(variable_name);
		      }
          } 
	    bb_gen_set.insert(make_pair(&BB, gen_set)); // get gen_set of each BB (that we have found before), in the map bb_gen_set, key: BB, value: its gen_set
        } 

/******************************************* out_set initialization *********************************************************/	
	for(BasicBlock &BB : F) {
	    if (&BB == first_bb) { 
		 bb_out_set.insert(make_pair(&BB, union_vector(bb_in_set[&BB], bb_gen_set[&BB]))); // we evaluate the exit state of the first BB as the union between the etntry state values (the argument list of the function F) and the genetation set of the first BB
		 new_bb_out_set.insert(make_pair(&BB, union_vector(bb_in_set[&BB], bb_gen_set[&BB])));//for the first bb, new_out_set=out_set (because we do not need to evaluate the exit state of the first BB anymore in the algorithm).
         	 continue;
	    }
        // Initialize every other bb_out_set and new_bb_out_set. 
        //For all BB states: it is the argument list variables plus the new variables that are allocated in the Function itself 
        //They are the initials of all new_bb_out_set. And we initialized all other bb_out_set as empty_set
	    bb_out_set.insert(make_pair(&BB, empty_set)); 
	    new_bb_out_set.insert(make_pair(&BB, allocate_set));
	}

/******************************************* bb_in_set initialization ******************************************************************/
	for(BasicBlock &BB : F) {//initilize input set, before except first bb, other BB in_set is empty
	    if (&BB == first_bb)
	           continue; // No need to deal with the in_set of the very first block
	    for (auto iter = pred_begin(&BB); iter != pred_end(&BB); ++iter) 
		   bb_in_set[&BB] = bb_out_set[*iter]; // initialize with allocate_set, that is, initialize in set with the value of the previous BB's out set
	}

/********************************************************************************************************************************************
            Step 2: Iteration: we implemante the while-algorithm that stops only if all the exit-states reached the fixing point
********************************************************************************************************************************************/
	int vector_counter;  
	int temp_counter; 
        bool flag = false; //falg is false at the beginning for the check for the first BB
    
// bb_in_set and bb_out_set are initialized by the same value except the first basic block
	while (!fixed_point(bb_out_set, new_bb_out_set, flag)) { // while new_out_set is not equal to out_set
	    for(BasicBlock &BB : F) {
                  if (&BB != first_bb) // go through all the predcessors of the basic block BB and add then to the input vector of the BB iff they intersect (both are true) with the already existing variables list (in this particular variable-name).
			for (auto iter = pred_begin(&BB); iter != pred_end(&BB); ++iter) //input set:get the precessor union of output
                        {
			    if(iter == pred_begin(&BB))
				   insert_temp = new_bb_out_set[*iter]; // *iter = pred_begin(&BB)
                            else
                   		   insert_temp = intersection_vector(insert_temp, new_bb_out_set[*iter]);
                                   bb_in_set[&BB] = insert_temp;
                         }
		  bb_out_set[&BB]= new_bb_out_set[&BB]; // get the value of out_set
		  new_bb_out_set[&BB] = union_vector(bb_in_set[&BB], bb_gen_set[&BB]); //new_out_set is the union of in_set and gen_set
              } 
	     flag = true; //all bb except the first need to have the flag set to true in order to get into fixed_point function for checking
	}

/******************************************************************************************************************************************
			Step 3: Distinguish the uninitialized variables. (only happens in Store and Load process)
******************************************************************************************************************************************/
	vector<string> check_vector; 
	map<int, vector<string>> results;
	int counter = 0;

	for(BasicBlock &BB : F) {
	    first_bb_temp.clear();
	    for(Instruction &I : BB) {
/**************************** Load Instruction ***************************************************/
            // For example: int a,b,c; a=3; b=c; (but c is not initialized yet)
		if(LoadInst *li = dyn_cast<LoadInst>(&I)) {
		    string variable_name = li->getOperand(0)->getName();
		    if((!variable_name.empty()) && find(bb_in_set[&BB].begin(), bb_in_set[&BB].end(), variable_name) == bb_in_set[&BB].end()){
			   if(find(first_bb_temp.begin(), first_bb_temp.end(), variable_name) != first_bb_temp.end())
                            continue;
                    DebugLoc Loc = li->getDebugLoc(); // get Load Instruction location, line number
                    check_vector.clear();
	            check_vector.push_back(variable_name); // insert LoadInst into check_vector
	            check_vector.push_back(to_string(Loc.getLine())); // add line number
	            results.insert(make_pair(counter, check_vector)); // insert all loadinst and its line number in the map called analysis_res
                    counter++;
		    }
                }
/***************************** Store Instruction **************************************************/
		else if(StoreInst *si = dyn_cast<StoreInst>(&I)) {
	            string variable_name = I.getOperand(1)->getName();
		    if((!variable_name.empty()) && (find(first_bb_temp.begin(), first_bb_temp.end(), variable_name) == first_bb_temp.end()))
	            	first_bb_temp.push_back(variable_name); 
			// insert stored variable in first_bb_temp for next loadinst to check against the load instruction. 
		        // If a variable is initialized then it can "be used" (only after its initialization) which we refer to as a loadinst. 
                        //For example: int a,c; c=5; a=c;
                }
            } 
        }
/******************************************************************************************************************************************
			step 4. Show the uninitialize variable as an output
******************************************************************************************************************************************/
    //Go over the results map in order to find for each uninitialized variable his name and the line that this "problem" occour
    for(auto iter = results.begin(); iter != results.end(); ++iter) { 
	    vector_counter = 0;
	    errs() << "Variable ";
	    for (auto iter2 = iter->second.begin(); iter2 != iter->second.end(); ++iter2) {
		errs() <<*iter2;
		if (vector_counter < 1) {
		    errs() << " may be uninitialized on line ";
		    vector_counter++;
		}
            }
            errs() <<"\n"; 
	 }
    // We did not modify the function
    return false;
  }
};

    
// The second pass fix the code by adding an initialization instruction for each non-initialized variable
class FixingPass : public FunctionPass {
public:
  static char ID;
  FixingPass() : FunctionPass(ID) {}

  virtual void getAnalysisUsage(AnalysisUsage &au) const {
    au.setPreservesCFG();
  }

  virtual bool runOnFunction(Function &F) {
    // TODO
/*
	For uninitialized variable, initialize it as: 
	int=10, 
	float=20, 
	double=30
    whenever a variable is used before initialization.
*/
	for(BasicBlock &BB : F) {
	    for(Instruction &I : BB) {
	        if(AllocaInst *ai = dyn_cast<AllocaInst>(&I)) {
		      string variable_name = I.getName();             
		      if(!variable_name.empty()) {
			      StoreInst *storeInst = NULL;
                              Constant *constant = NULL;                  
                //For all integer allocation instrructions
			    if(ai->getType() == Type::getInt32PtrTy(getGlobalContext())) {
			       constant = ConstantInt::get(Type::getInt32Ty(getGlobalContext()), 10); // initialize int as 10
			       storeInst = new StoreInst(constant, ai);
			       storeInst->setAlignment(4);
                            }    
                //For all float allocation instrructions
			    else if(ai->getType() == Type::getFloatPtrTy(getGlobalContext())) {
			       constant = ConstantFP::get(Type::getFloatTy(getGlobalContext()), 20); // initialize float as 20
                               storeInst = new StoreInst(constant, ai);
                               storeInst->setAlignment(4);
			    }
                //For all double allocation instrructions
			   else if(ai->getType() == Type::getDoublePtrTy(getGlobalContext())) {
			       constant = ConstantFP::get(Type::getDoubleTy(getGlobalContext()), 30); // initialize double as 30
			       storeInst = new StoreInst(constant, ai);
			       storeInst->setAlignment(8);
			    } 
               //Id storeInst is not empty then insert the new values
			   if(storeInst)
			       I.getParent()->getInstList().insertAfter(I, storeInst);
		       } //End of If-> for all not empty variables
		   } //End of If-> for all allocation instructions (for example: int a;)
	       } //End of Instruction-loop
	   } //End of BB-loop
    // We modified the function (fix the uninitialization problem) and change the IR
    return true;
  }
};

} // namespace


char DefinitionPass::ID = 0;
char FixingPass::ID = 1;

// Pass registrations
static RegisterPass<DefinitionPass> X("def-pass", "Uninitialized variable pass");
static RegisterPass<FixingPass> Y("fix-pass", "Fixing initialization pass");
