//
//  SequenceList.c
//  DataStructDemo
//
//  Created by 信辉科技 on 2020/1/3.
//  Copyright © 2020年 信辉科技. All rights reserved.
//

#include "SequenceList.h"

/* 顺序表函数列表 */
Status InitList_Sq(SqList *L)
{
    (*L).elem = (ElemType *)malloc(sizeof(ElemType) * LIST_INIT_SIZE);
    if (!(*L).elem) {
        exit(OVERFLOW);
    }
    
    (*L).length = 0;
    L->listSize = LIST_INIT_SIZE;
    
    return OK;
}
/*━━━━━━━━━━━━━━━┓
 ┃(01)算法2.3：初始化空顺序表L。┃
 ┗━━━━━━━━━━━━━━━*/

void ClearList_Sq(SqList *L)
{
    (*L).length = 0;
}
/*━━━━━━━━━┓
 ┃(02)清空顺序表L。 ┃
 ┗━━━━━━━━━*/

void DestroyList_Sq(SqList *L)
{
    free((*L).elem);
    
    (*L).elem = NULL;
    (*L).length = 0;
    (*L).listSize = 0;
}
/*━━━━━━━━━┓
 ┃(03)销毁顺序表L。 ┃
 ┗━━━━━━━━━*/

Status ListEmpty_Sq(SqList L)
{
    return L.length ==0 ? TRUE: FALSE;
}
/*━━━━━━━━━━━━━┓
 ┃(04)判断顺序表L是否为空。 ┃
 ┗━━━━━━━━━━━━━*/

int ListLength_Sq(SqList L)
{
    return L.length;
}
/*━━━━━━━━━━━━━━┓
 ┃(05)返回顺序表L中元素个数。 ┃
 ┗━━━━━━━━━━━━━━*/

Status GetElem_Sq(SqList L, int i, ElemType *e)
{
    if (i < 1 || i > L.length) {
        return ERROR;
    }
    
    *e = L.elem[i-1];
    return OK;
}
/*━━━━━━━━━━━━━━━━┓
 ┃(06)用e接收顺序表L中第i个元素。 ┃
 ┗━━━━━━━━━━━━━━━━*/

int LocateElem_Sq(SqList L, ElemType e, Status(Compare)(ElemType, ElemType))
{
//    for (int i = 1; i <= L.length; ++i) {
//        if (Compare(e, L.elem[i-1])) {
//            return i;
//        }
//    }
//    return 0;
    
    int i = 1;
    while (i <= L.length && !Compare(e, L.elem[i-1])) {
        ++i;
    }
    
    if (i <= L.length) {
        return i;
    } else {
        return 0;
    }
    
}
/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
 ┃(07)算法2.6：返回顺序表L中首个与e满足Compare关系的元素位序。┃
 ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/

Status PriorElem_Sq(SqList L, ElemType cur_e, ElemType *pre_e)
{
//    int i = 1;
//    while (i <= L.length && cur_e != L.elem[i-1]) {
//        ++i;
//    }
//    
//    if (i > 1 && i <= L.length) {
//        *pre_e = L.elem[i-1];
//        return OK;
//    } else {
//        return ERROR;
//    }
    
    int i = 1;
    if (L.elem[i-1] != cur_e) {
        // 第一个元素节点没有前驱
        ++i;
        while (i <= L.length && cur_e != L.elem[i-1]) {
            ++i;
        }
        
        if (i <= L.length) {
            *pre_e = L.elem[i-1];
            return OK;
        }
        
    }
    return ERROR;
}
/*━━━━━━━━━━━━━━━━━┓
 ┃(08)用pre_e接收cur_e的前驱。      ┃
 ┗━━━━━━━━━━━━━━━━━*/

Status NextElem_Sq(SqList L, ElemType cur_e, ElemType *next_e)
{
    int i = 1;
    while (i <= L.length -1 && cur_e != L.elem[i-1]) {
        ++i;
    }
    
    if (i <= L.length -1) {
        *next_e = L.elem[i];
        return OK;
    }
    return ERROR;
}
/*━━━━━━━━━━━━━━━━━┓
 ┃(09)用next_e接收cur_e的后继。     ┃
 ┗━━━━━━━━━━━━━━━━━*/

Status ListInsert_Sq(SqList *L, int i, ElemType e)
{
    if (i < 1 || i > (*L).length+1) {
        return ERROR;
    }
    
    if ((*L).length >= (*L).listSize) {
        // 需要重新开辟空间
        (*L).elem = (ElemType *)realloc((*L).elem, sizeof(ElemType) * ((*L).listSize + LISTINCREMENT));
        if (!(*L).elem) {
            exit(OVERFLOW);
        }
        (*L).listSize += LISTINCREMENT;
    }
    
    int j;
    for (j = (*L).length - 1; j >= i-1; --j) {
        (*L).elem[j] = (*L).elem[j+1];
    }
    (*L).elem[j] = e;
    (*L).listSize++;
    return OK;
    
}
/*━━━━━━━━━━━━━━━━━━━━━┓
 ┃(10)算法2.4：在顺序表L的第i个位置上插入e。┃
 ┗━━━━━━━━━━━━━━━━━━━━━*/

Status ListDelete_Sq(SqList *L, int i, ElemType *e)
{
    if (i < 1 || i > (*L).length) {
        return ERROR;
    }
    
    *e = (*L).elem[i-1];
    for (; i <= (*L).length; ++i) {
        (*L).elem[i-1] = (*L).elem[i];
    }
    (*L).length--;
    return OK;
}
/*━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
 ┃(11)算法2.5：删除顺序表L上第i个位置的元素，并用e返回。┃
 ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━*/

Status ListTraverse_Sq(SqList L, void (Visit)(ElemType))
{
    if (ListLength_Sq(L) > 0) {
        for (int i = 1; i <= L.length; ++i) {
            Visit(L.elem[i-1]);
        }
        return OK;
    }
    return ERROR;
}
/*━━━━━━━━━━━━━━┓
 ┃(12)用visit函数访问顺序表L。┃
 ┗━━━━━━━━━━━━━━*/
