double A [][] = { { 2.00, 7.00 }, { 6.00, -5.600 } };
double B [][] = { { -0.500, 1.500 }, { 1.000, -2.0000 } };
 
         int aRows = A.length;
        int aColumns = A[0].length;
        int bRows = B.length;
        int bColumns = B[0].length;
        
        //multiplicação
 double[][] C = new double[aRows][bColumns];
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 2; j++) {
                C[i][j] = 0.00000;
            }
        }
        
         for (int i = 0; i < aRows; i++) { // aRow
            for (int j = 0; j < bColumns; j++) { // bColumn
                for (int k = 0; k < aColumns; k++) { // aColumn
                    C[i][j] += A[i][k] * B[k][j];
                }
            }
        }
println(C[0][0],C[0][1]);
println(C[1][0],C[1][1]);

//transposta
 double[][] D = new double[aRows][bColumns];
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 2; j++) {
                D[i][j] = 0.00000;
            }
        }
        
         for (int i = 0; i < aRows; i++) { // aRow
            for (int j = 0; j < bColumns; j++) { // bColumn
                for (int k = 0; k < aColumns; k++) { // aColumn
                    D[i][j] = A[j][i];
                }
            }
         } 
            println();
            println(D[0][0],D[0][1]);
            println(D[1][0],D[1][1]);
       //soma     
            double[][] E = new double[aRows][bColumns];
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 2; j++) {
                E[i][j] = A[i][j]+B[i][j];
            }
        }
        println();
            println(E[0][0],E[0][1]);
            println(E[1][0],E[1][1]);
            
  //inversa          
            double[][] F = new double[aRows][bColumns];
            for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 2; j++) {
                F[i][j] = 0.00000;
            }
        }
        F[0][0]=A[1][1]/(A[0][0]*A[1][1] -A[0][1]*A[1][0]);
        F[0][1]=-A[0][1]/(A[0][0]*A[1][1] -A[0][1]*A[1][0]);
        F[1][0]=-A[1][0]/(A[0][0]*A[1][1] -A[0][1]*A[1][0]);
        F[1][1]=A[0][0]/(A[0][0]*A[1][1] -A[0][1]*A[1][0]);
            println();
            println(F[0][0],F[0][1]);
            println(F[1][0],F[1][1]);
            
        //garantir inversa    
           double[][] H = new double[aRows][bColumns];
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 2; j++) {
                H[i][j] = 0.00000;
            }
        }
        
         for (int i = 0; i < aRows; i++) { // aRow
            for (int j = 0; j < bColumns; j++) { // bColumn
                for (int k = 0; k < aColumns; k++) { // aColumn
                    H[i][j] += A[i][k] * F[k][j];
                }
            }
        }  
        
        println();
            println(H[0][0],H[0][1]);
            println(H[1][0],H[1][1]);