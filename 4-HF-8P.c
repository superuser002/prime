#include<stdio.h>
#include<stdlib.h>
#define N 3

int initialState[N][N];
int finalState[N][N];
int tempInitialState[N][N];
int tempR,tempC;

void print2dArray(int a[N][N])
{
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			printf("%d\t",a[i][j]);
		}
		printf("\n");
	}
}

void getInitialState()
{
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			scanf("%d",&initialState[i][j]);
		}
	}
}

void getFinalState()
{
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			scanf("%d",&finalState[i][j]);
		}
	}
}

void copyArray(int a[N][N],int b[N][N])
{
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			a[i][j] = b[i][j];
		}
	}
}


int moveEmptyBox(int a[N][N],int r,int c,int newr,int newc,int mdis)
{
	int temp,hdis=0;
	int tempArray[N][N];
	copyArray(tempArray,a);
	temp = tempArray[newr][newc];
	tempArray[newr][newc] = 0;
	tempArray[r][c] = temp;

	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			if (tempArray[i][j]!=0 && tempArray[i][j]!=finalState[i][j])
			{
				hdis++;
			}
		}
	}

	if (hdis<mdis)
	{
		copyArray(tempInitialState,tempArray);
		tempR = newr;
		tempC = newc;
		// print2dArray(tempInitialState);
	}
	return hdis;
}

void findFinalState()
{
	int r,c;
	int mdis = 99;
	for (int i = 0; i < 3; i++)
	{
		for (int j = 0; j < 3; j++)
		{
			if (initialState[i][j]==0)
			{
				r=i;
				c=j;
			}
		}
	}


	while(mdis!=0)
	{
		if(r-1>=0)
		{
			int hdis = moveEmptyBox(initialState,r,c,r-1,c,mdis);
			if (hdis < mdis)
			{
				// printf("r-1:%d\n",hdis);
				mdis = hdis;
			}
		}

		if (r+1<3)
		{
			int hdis = moveEmptyBox(initialState,r,c,r+1,c,mdis);
			if (hdis < mdis)
			{
				// printf("r+1:%d\n",hdis);
				mdis = hdis;
			}
		}

		if (c-1>=0)
		{
			int hdis = moveEmptyBox(initialState,r,c,r,c-1,mdis);
			if (hdis < mdis)
			{
				// printf("c-1:%d\n",hdis);
				mdis = hdis;
			}
		}

		if (c+1<0)
		{
			int hdis = moveEmptyBox(initialState,r,c,r,c+1,mdis);
			if (hdis < mdis)
			{
				// printf("c+1:%d\n",hdis);
				mdis = hdis;
			}
		}

		r=tempR;
		c=tempC;
		copyArray(initialState,tempInitialState);
		printf("\n");
		print2dArray(initialState);
	}
}


void main()
{
	printf("Enter the initial state:\n");
	getInitialState();
	printf("Initial State:\n");
	print2dArray(initialState);
	printf("\nEnter the final state:\n");
	getFinalState();

	printf("\nAll intermediate states:");
	findFinalState(initialState);
}
