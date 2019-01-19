#LIBRERIA DE TOPOLOGIA

def caractEuler(bettiList):
    #funcion que calcula la caracteristica de euler dada la lista de numeros de betti
    s=0
    
    
    for i in range(len(bettiList)):
        if (i%2==0):
            s+=bettiList[i]
        else:
            s-=bettiList[i]
    return s
    
def isTwin(e1,e2,D):
    return twin(e1,D)==e2 or twin(e2,D)==e1

def isTwinList(e,l,D):
    #indica si la arista e es gemela de alguna en la lista l tomando el DCEL D
    ar=D[1]
    res= False
    for i in range(len(l)):
 
            if  isTwin(e,l[i],D):
                res = True
    return res
    
def quitarGemelas(D):
    #D es un dcel
    E=D[1]
    sinRepes=[]
    for i in range(len(E)):
        for j in range(len(E[i])):

            if ((not (E[i][j] in sinRepes)) and (not(isTwinList(E[i][j],sinRepes,D))) ):
                sinRepes.append(E[i][j])
    return sinRepes 
    
def chainComplex(D): ## compare.

    Laux=quitarGemelas(D)
    #print(Laux)
    V = [i for i in range(len(D[0]))]#lista vertices
    LS = [[dist2(originCoords(i, D), originCoords(next(i, D), D)), i] for i in Laux]
    #LS es una lista con elementos de tipo [distancia, indice]
    LS = sorted(LS) #ordenaOrdenada tenemos que ordenar de mayor a menor por su longitud #order_by
    #print(LS)
    A=[]
    tri=[]
    A = [[origin(i[1],D),origin(next(i[1],D),D)] for i in LS]#lista aristas
    for i in range(1,len(D[2])):
        tri.append([dist2(circumcenter((originCoords(origin(faceEdges(i,D)[0],D),D)),(originCoords(origin(faceEdges(i,D)[1],D),D)),(originCoords(origin(faceEdges(i,D)[2],D),D))),originCoords(origin(faceEdges(i,D)[0],D),D)),origin(faceEdges(i,D)[0],D),origin(faceEdges(i,D)[1],D),origin(faceEdges(i,D)[2],D)])
    if len(faceEdges(0,D))==3:
        tri.append([dist2(circumcenter((originCoords(origin(faceEdges(0,D)[0],D),D)),(originCoords(origin(faceEdges(0,D)[1],D),D)),(originCoords(origin(faceEdges(0,D)[2],D),D))),originCoords(origin(faceEdges(0,D)[0],D),D)),origin(faceEdges(0,D)[0],D),origin(faceEdges(0,D)[1],D),origin(faceEdges(0,D)[2],D)])

    tri.sort()

    tri=[[tri[i][1],tri[i][2],tri[i][3]]for i in range( len(tri) )]

    return [V, A, tri]    
    
def alphaComplex(a,C,D):

    C0=[]
    C1 = [C[1][i] for i in range(len(C[1])) if dist2(originCoords(i, D), originCoords(next(i, D), D)) <= 2*a]
    #print(C1)
    for i in range(len(C1)):

            if not(C1[i][0] in C0):
                C0.append(C1[i][0])
            if not(C1[i][1] in C0):
                C0.append(C1[i][1])
    C0=sorted(C0)
    F = [faceEdges(i, D) for i in range(len(C[2]))]
    C2 = [C[2][i] for i in range(len(C[2])) if dist2(circumcenter(originCoords(F[i][0], D), originCoords(F[i][1], D), originCoords(F[i][2], D)), originCoords(F[i][0], D)) <= a]
    return [C0, C1, C2]    
    
def plotAlphaComplex(A,D):
    #A es alfa-complejo y D dcel
    vertices=A[0]
    aristas=A[1]
    tri=A[2]
    
    p = point(originCoords(A[0][0],D))
    #for i in range(len(aristas)):
    return  sum(line([originCoords(aristas[i][0], D), originCoords(aristas[i][1], D)],aspect_ratio=1) for i in range(len(aristas)))    
    
def buildD1(A):
    #método para construir la matriz de incidencia D1
    verts=A[0]
    #print(verts)
    ars=A[1]
    #print(ars)
    mat=[]
    
    for i in range(len(verts)):
        fila=[]
        for j in range(len(ars)):
            
            if(verts[i] in ars[j]):

                fila.append(1)
            else:

                fila.append(0)

        mat.append(fila)
    return matrix(GF(2),mat)
    
def buildD2(A):
    
    #print(verts)
    ars=A[1]
    #print(ars)
    tri=A[2]
    mat=[]
    
    for i in range(len(ars)):
        fila=[]
        for j in range(len(tri)):
            
            if(ars[i][0] in tri[j] and ars[i][1] in tri[j]):

                fila.append(1)
            else:

                fila.append(0)

        mat.append(fila)
    return matrix(GF(2),mat)    
    
def bettiNumbers(A):
    #construimos las matrices de incidencia
    D0=matrix(GF(2),1,len(A[0]),[i*0 for i in range(len(A[0]))])
    #print(D0)
    D1=buildD1(A)
    D2=buildD2(A)
    print("Resto")
    B1=D0.right_kernel().dimension()-D1.transpose().rank()
    B2=D1.right_kernel().dimension()-D2.rank()
    
    return [B1,B2]    
    
    
    
    
    
    
    
