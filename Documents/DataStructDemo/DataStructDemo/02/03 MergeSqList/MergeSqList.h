//
//  MergeSqList.h
//  DataStructDemo
//
//  Created by 信辉科技 on 2020/1/3.
//  Copyright © 2020年 信辉科技. All rights reserved.
//

#ifndef MergeSqList_h
#define MergeSqList_h

#include <stdio.h>
#include "SequenceList.h"

/* 顺序表归并函数列表 */
void MergeSqList_1(SqList La, SqList Lb, SqList *Lc);
/*━━━━━━━━━━━━━━━━━━━━━┓
 ┃(01)算法2.2：求C=A+B，A,B,C均为非递减序列 ┃
 ┗━━━━━━━━━━━━━━━━━━━━━*/

void MergeSqList_2(SqList La, SqList Lb, SqList *Lc);
/*━━━━━━━━━━━━━━━━━━━━━┓
 ┃(02)算法2.7：求C=A+B，A,B,C均为非递减序列 ┃
 ┗━━━━━━━━━━━━━━━━━━━━━*/
#endif /* MergeSqList_h */
