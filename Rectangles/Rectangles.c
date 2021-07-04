__asm__(".code16\n");
__asm__("jmpl $0x0000, $main\n");

void drawPixel(unsigned char color, int col, int row) 
{
     __asm__ __volatile__ (
          "int $0x10" : : "a"(0x0c00 | color), "c"(col), "d"(row)
     );
}

void draw() 
{
     int MAX_ROWS=200, MAX_COLS=320, i=0, j=0, m=0, gap=10, cnt1=0, cnt2=0;
     unsigned char color = 20;

     while(1)
     {
          if(m < (MAX_ROWS-m))
               ++cnt1;
          if(m < (MAX_COLS-m-3)) 
               ++cnt2;

          if(cnt1!=cnt2) 
	  {
               cnt1 = 0;
               cnt2 = 0;
               m = 0;
               if(color>254) 
		  color= 0;
          }

          j = 0;
          for(i=m; i<MAX_ROWS-m; i++)
               drawPixel(color, j+m, i);

          for(j=m; j<MAX_COLS-m; j++)
               drawPixel(color, j, i);
          
          for(i=MAX_ROWS-m-1 ; i>=m; i--)
               drawPixel(color, MAX_COLS - m - 1, i);
          
          for(j=MAX_COLS-m-1; j>=m; j--) 
               drawPixel(color, j, m);
          
          m += gap;
          if(color>254)  
		  color = 0;
     }
}

int main() {
     __asm__ __volatile__ ("int $0x10" : : "a"(0x03));
     __asm__ __volatile__ ("int $0x10" : : "a"(0x0013));
     draw();
     return 0;
}
