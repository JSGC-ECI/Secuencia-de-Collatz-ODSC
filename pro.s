#include <stdio.h>
#include <string.h>

#define MAX 1005

void quitarCeros(char num[]) {
    int i = 0;
    while (num[i] == '0' && num[i + 1] != '\0') {
        i++;
    }
    if (i > 0) {
        int j = 0;
        while (num[i]) {
            num[j++] = num[i++];
        }
        num[j] = '\0';
    }
}

int comparar(char a[], char b[]) {

    int la = strlen(a);
    int lb = strlen(b);
    if (la > lb) return 1;
    if (la < lb) return -1;

    for (int i = 0; i < la; i++) {
        if (a[i] > b[i]) return 1;
        if (a[i] < b[i]) return -1;
    }

    return 0;
}

void complementoA9(char b[], char res[]) {
    int len = strlen(b);
    for (int i = 0; i < len; i++) {
        res[i] = '9' - b[i] + '0';
    }
    res[len] = '\0';
}

void sumaConAcarreo(char a[], char b[], char res[]) {
    int la = strlen(a);
    int lb = strlen(b);
    int max = (la > lb) ? la : lb;
    char temp[MAX];
    int acarreo = 1;
    int i = la - 1, j = lb - 1, k = 0;

    while (max--) {
        int da = (i >= 0) ? a[i] - '0' : 0;
        int db = (j >= 0) ? b[j] - '0' : 0;
        int suma = da + db + acarreo;

        acarreo = suma / 10;
        temp[k++] = (suma % 10) + '0';
        i--; j--;
    }

    if (acarreo == 1)
        temp[k++] = '1';


    for (int m = 0; m < k; m++) {
        res[m] = temp[k - 1 - m];
    }
    res[k] = '\0';
}


void restarComplemento9(char a[], char b[], char res[]) {
    char b9[MAX], suma[MAX];
    int lenA = strlen(a), lenB = strlen(b);

    char bPadded[MAX];
    int dif = lenA - lenB;
    for (int i = 0; i < dif; i++) bPadded[i] = '0';
    for (int i = 0; i < lenB; i++) bPadded[dif + i] = b[i];
    bPadded[lenA] = '\0';

    complementoA9(bPadded, b9);
    sumaConAcarreo(a, b9, suma);

    strcpy(res, suma + 1);
}

void dividir(char a[], char b[], char cociente[], char residuo[]) {
    char actual[MAX], temp[MAX], uno[] = "1";
    int len = strlen(a);
    int ci = 0;

    char parte[MAX] = "";

    for (int i = 0; i < len; i++) {
        int l = strlen(parte);
        parte[l] = a[i];
        parte[l + 1] = '\0';
        quitarCeros(parte);

        int cuenta = 0;
        while (comparar(parte, b) >= 0) {
            restarComplemento9(parte, b, temp);
            strcpy(parte, temp);
            cuenta++;
        }

        cociente[ci++] = cuenta + '0';
    }

    cociente[ci] = '\0';
    quitarCeros(cociente);

    if (strlen(parte) == 0)
        strcpy(residuo, "0");
    else
        strcpy(residuo, parte);
}

void main() {
    int T;
    char a[MAX], b[MAX], coc[MAX], res[MAX];
    scanf("%d", &T);
    for (int i = 0; i < T; i++) {
        scanf("%s", a);
        scanf("%s", b);

        dividir(a, b, coc, res);

        printf("%s\n", coc);
        printf("%s\n", res);
    }
}
