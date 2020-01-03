//
//  Union.c
//  DataStructDemo
//
//  Created by 信辉科技 on 2020/1/3.
//  Copyright © 2020年 信辉科技. All rights reserved.
//

#include "Union.h"
/* 并集函数列表 */
void Union(SqList *La, SqList Lb)
{
    int La_len = ListLength_Sq(*La);
    int Lb_len = ListLength_Sq(Lb);
    ElemType e;
    
    for (int i = 1; i <= Lb_len; ++i) {
        GetElem_Sq(Lb, i, &e);
        if (!LocateElem_Sq(*La, e, equal)) {
            ListInsert_Sq(La, ++La_len, e);
        }
    }
}
/*━━━━━━━━━━━┓
 ┃(01)算法2.1：A=A∪B。 ┃
 ┗━━━━━━━━━━━*/

Status equal(ElemType e1, ElemType e2)
{
    return e1 == e2? TRUE: FALSE;
}
/*━━━━━━━━━━━━┓
 ┃(02)判断两元素是否相等。┃
 ┗━━━━━━━━━━━━*/
