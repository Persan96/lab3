#include <stdio.h>
#include "calc3.h"
#include "y.tab.h"

static int lbl;

int ex(nodeType *p) {
    int lbl1, lbl2;

    if (!p) return 0;
    switch(p->type) {
    case typeCon:
        printf("\tmovabsq\t$%lli, \%rax\n", p->con.value);
	      printf("\tpushq\t\%rax\n");
        break;
    case typeId:
        printf("\tpushq\t%c\n", p->id.i + 'a');
        break;
    case typeOpr:
        switch(p->opr.oper) {
        case WHILE:
            printf("L%03d:\n", lbl1 = lbl++);
            ex(p->opr.op[0]);
            printf("\tjne\tL%03d\n", lbl2 = lbl++);
            ex(p->opr.op[1]);
            printf("\tjmp\tL%03d\n", lbl1);
            printf("L%03d:\n", lbl2);
            break;
        case IF:
            ex(p->opr.op[0]);
            if (p->opr.nops > 2) {
                /* if else */
                printf("\tjne\tL%03d\n", lbl1 = lbl++);
                ex(p->opr.op[1]);
                printf("\tjmp\tL%03d\n", lbl2 = lbl++);
                printf("L%03d:\n", lbl1);
                ex(p->opr.op[2]);
                printf("L%03d:\n", lbl2);
            } else {
                /* if */
                printf("\tjne\tL%03d\n", lbl1 = lbl++);
                ex(p->opr.op[1]);
                printf("L%03d:\n", lbl1);
            }
            break;
        case PRINT:
            ex(p->opr.op[0]);
            printf("\tcall\tstackPrint\n");
            break;
        case '=':
            ex(p->opr.op[1]);
            printf("\tpopq\t%c\n", p->opr.op[0]->id.i + 'a');
            break;
        case UMINUS:
            ex(p->opr.op[0]);
            printf("\tcall\tstackNeg\n");
            break;
	case FACT:
  	    ex(p->opr.op[0]);
	    printf("\tcall\tstackFact\n");
	    break;
	case LNTWO:
	    ex(p->opr.op[0]);
	    printf("\tcall\tstackLntwo\n");
	    break;
        default:
            ex(p->opr.op[0]);
            ex(p->opr.op[1]);
            switch(p->opr.oper) {
	    case GCD:   printf("\tcall\tstackGCD\n"); break;
            case '+':   printf("\tcall\tstackAdd\n"); break;
            case '-':   printf("\tcall\tstackSub\n"); break;
            case '*':   printf("\tcall\tstackMul\n"); break;
            case '/':   printf("\tcall\tstackDiv\n"); break;
            case '<':   printf("\tcall\tstackCompLT\n"); break;
            case '>':   printf("\tcall\tstackCompGT\n"); break;
            case GE:    printf("\tcall\tstackCompGE\n"); break;
            case LE:    printf("\tcall\tstackCompLE\n"); break;
            case NE:    printf("\tcall\tstackCompNE\n"); break;
            case EQ:    printf("\tcall\tstackCompEQ\n"); break;
            }
        }
    }
    return 0;
}
