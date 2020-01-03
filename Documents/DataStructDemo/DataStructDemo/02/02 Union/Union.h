//
//  Union.h
//  DataStructDemo
//
//  Created by 信辉科技 on 2020/1/3.
//  Copyright © 2020年 信辉科技. All rights reserved.
//

#ifndef Union_h
#define Union_h

#include <stdio.h>
#include "SequenceList.h"

/* 并集函数列表 */
void Union(SqList *La, SqList Lb);
/*━━━━━━━━━━━┓
 ┃(01)算法2.1：A=A∪B。 ┃
 ┗━━━━━━━━━━━*/

Status equal(ElemType e1, ElemType e2);
/*━━━━━━━━━━━━┓
 ┃(02)判断两元素是否相等。┃
 ┗━━━━━━━━━━━━*/

#endif /* Union_h */
