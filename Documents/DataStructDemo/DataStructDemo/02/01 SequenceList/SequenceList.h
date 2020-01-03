//
//  SequenceList.h
//  DataStructDemo
//
//  Created by 信辉科技 on 2020/1/3.
//  Copyright © 2020年 信辉科技. All rights reserved.
//

#ifndef SequenceList_h
#define SequenceList_h

#include <stdio.h>
#include "Status.h"

#define LIST_INIT_SIZE 100
#define LISTINCREMENT 10
typedef int ElemType;
typedef struct {
    ElemType *elem;
    int length;
    int listSize;
}SqList;

/* 顺序表函数列表 */
Status InitList_Sq(SqList *L);
/*━━━━━━━━━━━━━━━┓
 ┃(01)算法2.3：初始化空顺序表L。┃
 ┗━━━━━━━━━━━━━━━*/

void ClearList_Sq(SqList *L);
/*━━━━━━━━━┓
 ┃(02)清空顺序表L。 ┃
 ┗━━━━━━━━━*/

void DestroyList_Sq(SqList *L);
/*━━━━━━━━━┓
 ┃(03)销毁顺序表L。 ┃
 ┗━━━━━━━━━*/

Status ListEmpty_Sq(SqList L);
/*━━━━━━━━━━━━━┓
 ┃(04)判断顺序表L是否为空。 ┃
 ┗━━━━━━━━━━━━━*/

int ListLength_Sq(SqList L);
/*━━━━━━━━━━━━━━┓
 ┃(05)返回顺序表L中元素个数。 ┃
 ┗━━━━━━━━━━━━━━*/

Status GetElem_Sq(SqList L, int i, ElemType *e);
/*━━━━━━━━━━━━━━━━┓
 ┃(06)用e接收顺序表L中第i个元素。 ┃
 ┗━━━━━━━━━━━━━━━━*/

int LocateElem_Sq(SqList L, ElemType e, Status(Compare)(ElemType, ElemType));
/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
 ┃(07)算法2.6：返回顺序表L中首个与e满足Compare关系的元素位序。┃
 ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/

Status PriorElem_Sq(SqList L, ElemType cur_e, ElemType *pre_e);
/*━━━━━━━━━━━━━━━━━┓
 ┃(08)用pre_e接收cur_e的前驱。      ┃
 ┗━━━━━━━━━━━━━━━━━*/

Status NextElem_Sq(SqList L, ElemType cur_e, ElemType *next_e);
/*━━━━━━━━━━━━━━━━━┓
 ┃(09)用next_e接收cur_e的后继。     ┃
 ┗━━━━━━━━━━━━━━━━━*/

Status ListInsert_Sq(SqList *L, int i, ElemType e);
/*━━━━━━━━━━━━━━━━━━━━━┓
 ┃(10)算法2.4：在顺序表L的第i个位置上插入e。┃
 ┗━━━━━━━━━━━━━━━━━━━━━*/

Status ListDelete_Sq(SqList *L, int i, ElemType *e);
/*━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
 ┃(11)算法2.5：删除顺序表L上第i个位置的元素，并用e返回。┃
 ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━*/

Status ListTraverse_Sq(SqList L, void (Visit)(ElemType));
/*━━━━━━━━━━━━━━┓
 ┃(12)用visit函数访问顺序表L。┃
 ┗━━━━━━━━━━━━━━*/

#endif /* SequenceList_h */
