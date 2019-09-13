#include "llvm/Pass.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
using namespace llvm;

namespace {
    struct CheckFabs : public BasicBlockPass {
        static char ID;
        CheckFabs() : BasicBlockPass(ID) {}
 
        bool runOnBasicBlock(BasicBlock &BB) {
            for (BasicBlock::iterator I = BB.begin(), IE = BB.end(); I != IE; ++I) {
                if (isa<CallInst>(I)) {
                    Function *calledFunc = cast<CallInst>(I)->getCalledFunction();
                    if (calledFunc) { // in case it is a indirect call
                        StringRef name = calledFunc->getName();
                            if (name.compare("llvm.fabs.f64") == 0 ||
                                name.compare("llvm.fabs.f32") == 0 ||
                                name.compare("llvm.fabs.f80") == 0) {
                                IRBuilder<> builder(&BB);
                                Module *M = BB.getModule();
								Value *str = builder.CreateGlobalStringPtr(
                                    cast<CallInst>(I)->getFunction()->getName(), ""
                                );

                                // construct args for puts
                                std::vector<Type *> putsArgs;
                                putsArgs.push_back(builder.getInt8Ty()->getPointerTo());
                                ArrayRef<Type*>  argsRef(putsArgs);
                                 
                                // construct puts instruction
                                FunctionType *putsType = FunctionType::get(builder.getInt32Ty(), argsRef, false);
                                Constant *putsFunc = M->getOrInsertFunction("puts", putsType);
								Instruction *callPuts = CallInst::Create(putsFunc, ArrayRef< Value* >{str}, "");
                                
                                // insert puts instruction
                                callPuts->insertAfter(cast<CallInst>(I));
                            }
                    }
                }
            }
            return true;
        }
    };

    struct RmFabs : public BasicBlockPass {
        static char ID;
        RmFabs() : BasicBlockPass(ID) {}
 
        bool runOnBasicBlock(BasicBlock &BB) {
            for (BasicBlock::iterator I = BB.begin(), IE = BB.end(); I != IE; ++I) {
                if (isa<CallInst>(I)) {
                    Function *calledFunc = cast<CallInst>(I)->getCalledFunction();
                    if (calledFunc) { // in case it is a indirect call
                        StringRef name = calledFunc->getName();
                            if (name.compare("llvm.fabs.f64") == 0 ||
                                name.compare("llvm.fabs.f32") == 0 ||
                                name.compare("llvm.fabs.f80") == 0) {
                                
                                // replace instruction calling llvm.fabs.f64 with its argument as value
                                Value *arg = cast<CallInst>(I)->getArgOperand(0);
                                ReplaceInstWithValue(BB.getInstList(), I, arg);
                            }
                    }
                }
            }
            return true;
        }
    };
}

char CheckFabs::ID = 0;
static RegisterPass<CheckFabs> Y("checkfabs", "print function if it calls llvm.fabs.fXX");

char RmFabs::ID = 0;
static RegisterPass<RmFabs> X("rmfabs", "Remove llvm.fabs.fXX");
