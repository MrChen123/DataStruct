//
//  MergeSqList.c
//  DataStructDemo
//
//  Created by 信辉科技 on 2020/1/3.
//  Copyright © 2020年 信辉科技. All rights reserved.
//

#include "MergeSqList.h"
/* 顺序表归并函数列表 */
void MergeSqList_1(SqList La, SqList Lb, SqList *Lc)
{
//    (*Lc).elem = (ElemType *)malloc(sizeof(ElemType) * (La.length + Lb.length));
//    if (!(*Lc).elem) {
//        exit(OVERFLOW);
//    }
//    (*Lc).length = La.length + Lb.length;
//    (*Lc).listSize = (*Lc).length;
//
//    int i,j,k;
//    i = j = k = 0;
//    while (i < La.length && j < Lb.length) {
//        if (La.elem[i] <= Lb.elem[j]) {
//            (*Lc).elem[k++] = La.elem[i++];
//        } else {
//            (*Lc).elem[k++] = Lb.elem[j++];
//        }
//    }
//
//    while (i < La.length) {
//        (*Lc).elem[k++] = La.elem[i++];
//    }
//
//    while (j < Lb.length) {
//        (*Lc).elem[k++] = Lb.elem[j++];
//    }
    
    ElemType *pa,*pb,*pc;
    ElemType *pa_last, *pb_last;
    (*Lc).listSize = La.length + Lb.length;
    (*Lc).elem = (ElemType *)malloc(sizeof(ElemType) * (*Lc).listSize);
    if (!(*Lc).elem) {
        exit(OVERFLOW);
    }
    (*Lc).length = (*Lc).listSize;
    pa = La.elem;
    pb = Lb.elem;
    pc = (*Lc).elem;
    pa_last = La.elem + La.length -1;
    pb_last = Lb.elem + Lb.length -1;
    while (pa <= pa_last && pb <= pb_last) {
        if ((*pa) <= (*pb)) {
            *pc++ = *pa++;
        } else {
            *pc++ = *pb++;
        }
    }
    
    while (pa <= pa_last) {
        *pc++ = *pa++;
    }
    
    while (pb <= pb_last) {
        *pc++ = *pb++;
    }
    
}
/*━━━━━━━━━━━━━━━━━━━━━┓
 ┃(01)算法2.2：求C=A+B，A,B,C均为非递减序列 ┃
 ┗━━━━━━━━━━━━━━━━━━━━━*/

void MergeSqList_2(SqList La, SqList Lb, SqList *Lc)
{
    InitList_Sq(Lc);
    int La_len, Lb_len;
    int i, j, k;
    ElemType a, b;
    i = j = k =0;
    La_len = ListLength_Sq(La);
    Lb_len = ListLength_Sq(Lb);
    while (i < La_len && j < Lb_len) {
        GetElem_Sq(La, i, &a);
        GetElem_Sq(Lb, j, &b);
        
        if (a <= b) {
            ListInsert_Sq(Lc, ++k, a);
            ++i;
        } else {
            ListInsert_Sq(Lc, ++k, b);
            ++j;
        }
    }
    
    while (i < La_len) {
        GetElem_Sq(La, i++, &a);
        ListInsert_Sq(Lc, ++k, a);
    }
    
    while (j < Lb_len) {
        GetElem_Sq(Lb, j++, &b);
        ListInsert_Sq(Lc, ++k, b);
    }
    
}
/*━━━━━━━━━━━━━━━━━━━━━┓
 ┃(02)算法2.7：求C=A+B，A,B,C均为非递减序列 ┃
 ┗━━━━━━━━━━━━━━━━━━━━━*/
