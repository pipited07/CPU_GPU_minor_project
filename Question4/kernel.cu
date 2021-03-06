#include "cuda_runtime.h"
#include<stdio.h>
#include<malloc.h>
#include<math.h>
#include "kernel.h"

double *d_answer;
double *h_answer;

void Allocate_Memory()
{

	cudaError_t Error;
	size_t size = N * sizeof(double);
	h_answer = (double*)malloc(size);
	cudaMalloc((void**)&d_answer, size);

}

void Free_Memory()
{
	if (h_answer) free(h_answer);
	if (d_answer) cudaFree(d_answer);
}
void Send_To_Device()
{
	size_t size = N * sizeof(double);
	cudaMemcpy(d_answer, h_answer, size, cudaMemcpyHostToDevice);	
}
void Get_From_Memory()
{
	size_t size = N * sizeof(double);
	cudaMemcpy(h_answer, d_answer, size, cudaMemcpyDeviceToHost);	
}

__global__ void hardy_cross(double * ��_a)
{
	
	double Q01 = 5;
	double Q03 = 5;
	double Q12 = 2;
	double Q16 = 3;
	double Q24 = 1;
	double Q25 = 0;
	double Q34 = 0;
	double Q38 = 5;
	double Q47 = 1;
	double Q56 = 1;
	double Q57 = 0;
	double Q69 = 4;
	double Q78 = 1;
	double Q89 = 6;

	double r01 = 1;
	double r03 = 5;
	double r12 = 1;
	double r16 = 5;
	double r24 = 1;
	double r25 = 1;
	double r34 = 3;
	double r38 = 3;
	double r47 = 1;
	double r56 = 3;
	double r57 = 1;
	double r69 = 3;
	double r78 = 2;
	double r89 = 3;

	double c01 = 0;
	double c03 = 0;
	double c12 = 0;
	double c16 = 0;
	double c24 = 0;
	double c25 = 0;
	double c34 = 0;
	double c38 = 0;
	double c47 = 0;
	double c56 = 0;
	double c57 = 0;
	double c69 = 0;
	double c78 = 0;
	double c89 = 0;


	double dQ_1;
	double dQ_2;
	double dQ_3;
	double dQ_4;
	double dQ_5;

	int no_iteraion = 100;

	for (int i = 0; i < no_iteraion; i++)
	{
		if (Q01 != 0)
			c01 = Q01 / fabs(Q01);
		if (Q03 != 0)
			c03 = Q03 / fabs(Q03);
		if (Q12 != 0)
			c12 = Q12 / fabs(Q12);
		if (Q16 != 0)
			c16 = Q16 / fabs(Q16);
		if (Q24 != 0)
			c24 = Q24 / fabs(Q24);
		if (Q25 != 0)
			c25 = Q25 / fabs(Q25);
		if (Q34 != 0)
			c34 = Q34 / fabs(Q34);
		if (Q38 != 0)
			c38 = Q38 / fabs(Q38);
		if (Q47 != 0)
			c47 = Q47 / fabs(Q47);
		if (Q56 != 0)
			c56 = Q56 / fabs(Q56);
		if (Q57 != 0)
			c57 = Q57 / fabs(Q57);
		if (Q69 != 0)
			c69 = Q69 / fabs(Q69);
		if (Q78 != 0)
			c78 = Q78 / fabs(Q78);
		if (Q89 != 0)
			c89 = Q89 / fabs(Q89);



		dQ_1 = -(c01*r01 *Q01 *Q01 + c12*r12*Q12*Q12 + c24*r24*Q24*Q24 - c34*r34*Q34*Q34 - c03*r03*Q03*Q03)
			/ (2 * r01*fabs(Q01) + 2 * r12*fabs(Q12) + 2 * r24*fabs(Q24) + 2 * r34*fabs(Q34) + 2 * r03*fabs(Q03));

		dQ_2 = -(c16*r16 *Q16 *Q16 - c56*r56*Q56*Q56 - c25*r25*Q25*Q25 - c12*r12*Q12*Q12)
			/ (2 * r16*fabs(Q16) + 2 * r56*fabs(Q56) + 2 * r25*fabs(Q25) + 2 * r12*fabs(Q12));

		dQ_3 = -(c25*r25 *Q25 *Q25 + c57*r57*Q57*Q57 - c47*r47*Q47*Q47 - c24*r24*Q24*Q24)
			/ (2 * r25*fabs(Q25) + 2 * r57*fabs(Q57) + 2 * r47*fabs(Q47) + 2 * r24*fabs(Q24));

		dQ_4 = -(c34*r34 *Q34 *Q34 + c47*r47*Q47*Q47 + c78*r78*Q78*Q78 - c38*r38*Q38*Q38)
			/ (2 * r34*fabs(Q34) + 2 * r47*fabs(Q47) + 2 * r78*fabs(Q78) + 2 * r38*fabs(Q38));

		dQ_5 = -(c56*r56 *Q56 *Q56 + c69*r69*Q69*Q69 - c89*r89*Q89*Q89 - c78*r78*Q78*Q78 - c57*r57*Q57*Q57)
			/ (2 * r56*fabs(Q56) + 2 * r12*fabs(Q12) + 2 * r89*fabs(Q89) + 2 * r78*fabs(Q78) + 2 * r57*fabs(Q57));

		Q01 = Q01 + dQ_1;
		Q03 = Q03 - dQ_1;
		Q12 = Q12 + dQ_1 - dQ_2;
		Q16 = Q16 + dQ_2;
		Q24 = Q24 + dQ_1 - dQ_3;
		Q25 = Q25 - dQ_2 + dQ_3;
		Q34 = Q34 - dQ_1 + dQ_4;
		Q38 = Q38 - dQ_4;
		Q47 = Q47 - dQ_3 + dQ_4;
		Q56 = Q56 - dQ_2 + dQ_5;
		Q57 = Q57 + dQ_3 - dQ_5;
		Q69 = Q69 + dQ_5;
		Q78 = Q78 + dQ_4 - dQ_5;
		Q89 = Q89 - dQ_5;
	}
	��_a[0] = Q01;
	��_a[1] = Q03;
	��_a[2] = Q12;
	��_a[3] = Q16;
	��_a[4] = Q24;
	��_a[5] = Q25;
	��_a[6] = Q34;
	��_a[7] = Q38;
	��_a[8] = Q47;
	��_a[9] = Q56;
	��_a[10] = Q57;
	��_a[11] = Q69;
	��_a[12] = Q78;
	��_a[13] = Q89;
}


void Launch_hardy_cross()
{
	hardy_cross << <1, 1 >> > (d_answer);
}

