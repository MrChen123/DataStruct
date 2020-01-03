//
//  SinglyLinkedList.h
//  DataStructDemo
//
//  Created by 信辉科技 on 2020/1/3.
//  Copyright © 2020年 信辉科技. All rights reserved.
//

#ifndef SinglyLinkedList_h
#define SinglyLinkedList_h

#include <stdio.h>
#include "Status.h"

typedef int ElemType;
typedef struct Node {
    ElemType data;
    struct Node *next;
}Node, *LinkList;

/* 单链表（带头结点）函数列表 */
Status InitList_L(LinkList *L);
/*━━━━━━━━━━┓
 ┃(01)初始化单链表L。 ┃
 ┗━━━━━━━━━━*/

Status ClearList_L(LinkList L);
/*━━━━━━━━━━━━━━━┓
 ┃(02)置空单链表L，头结点保留。 ┃
 ┗━━━━━━━━━━━━━━━*/

void DestroyList_L(LinkList *L);
/*━━━━━━━━━━━━━━━━━━━┓
 ┃(03)销毁单链表L，连同通结点一起销毁。 ┃
 ┗━━━━━━━━━━━━━━━━━━━*/

Status ListEmpty_L(LinkList L);
/*━━━━━━━━━━━━━━━┓
 ┃(04)判断单链表L是否为空。     ┃
 ┗━━━━━━━━━━━━━━━*/

int ListLength_L(LinkList L);
/*━━━━━━━━━━━━┓
 ┃(05)返回单链表L元素个数 ┃
 ┗━━━━━━━━━━━━*/

Status GetElem_L(LinkList L, int i, ElemType *e);
/*━━━━━━━━━━━━━━━━━━━┓
 ┃(06)算法2.8：用e接收单链表L中第i个元素┃
 ┗━━━━━━━━━━━━━━━━━━━*/

int LocateElem_L(LinkList L, ElemType e, Status(Compare)(ElemType, ElemType));
/*━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
 ┃(07)返回单链表L中第一个与e满足Compare关系的元素位序。 ┃
 ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━*/

Status PriorElem_L(LinkList L, ElemType cur_e, ElemType *pre_e);
/*━━━━━━━━━━━━━━┓
 ┃(08)用pre_e接收cur_e的前驱。┃
 ┗━━━━━━━━━━━━━━*/

Status NextElem_L(LinkList L, ElemType cur_e, ElemType *next_e);
/*━━━━━━━━━━━━━━━┓
 ┃(09)用next_e接收cur_e的后继。 ┃
 ┗━━━━━━━━━━━━━━━*/

Status ListInsert_L(LinkList L, int i, ElemType e);
/*━━━━━━━━━━━━━━━━━━━━━┓
 ┃(10)算法2.9：在单链表L第i个位置之前插入e。┃
 ┗━━━━━━━━━━━━━━━━━━━━━*/

Status ListDelete_L(LinkList L, int i, ElemType *e);
/*━━━━━━━━━━━━━━━━━━━━━━━━━━┓
 ┃(11)算法2.10：删除单链表L第i个位置的值，并用e接收。 ┃
 ┗━━━━━━━━━━━━━━━━━━━━━━━━━━*/

Status ListTraverse_L(LinkList L, void(Visit)(ElemType));
/*━━━━━━━━━━━━━━┓
 ┃(12)用Visit函数访问单链表L。┃
 ┗━━━━━━━━━━━━━━*/

Status CreateList_HL(FILE *fp, LinkList *L, int n);
/*━━━━━━━━━━━━━━━━━━━━━━┓
 ┃(13)算法2.11：头插法建立单链表L(逆序输入)。 ┃
 ┗━━━━━━━━━━━━━━━━━━━━━━*/

Status CreateList_TL(FILE *fp, LinkList *L, int n);
/*━━━━━━━━━━━━━━━━━┓
 ┃(14)尾插法建立单链表L(顺序输入)。 ┃
 ┗━━━━━━━━━━━━━━━━━*/

#endif /* SinglyLinkedList_h */
