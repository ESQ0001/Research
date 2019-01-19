#LIBRERIA DE GTC

def dist(A,B):
     sum=(A[0]-B[0])*(A[0]-B[0])+(A[1]-B[1])*(A[1]-B[1])
     return sqrt(sum);
     
     
def dist2(A,B):
    
    return (A[0]-B[0])*(A[0]-B[0])+(A[1]-B[1])*(A[1]-B[1]);
    
def sarea(A,B,C):
    return (((B[0]-A[0])*(C[1]-A[1]))-((B[1]-A[1])*(C[0]-A[0])))/2;
    
def orientation(A,B,C):
    if sarea(A,B,C)>0 :
        #print ("Orientacion positiva")
        return 1;#asignamos un 1 a orientación positiva
    else:
        #print("Orientacion negativa")
        return 0;#asignamos un 0 a orientación negativa
        
def midPoint(A,B):
    
    return [(A[0]+B[0])/2,(A[1]+B[1])/2];
    
#sabemos que el area de tres puntos alineados es cero. Lo primero que hacemos es comprobar si están alineados y  si el punto se #encuentra en el segmento sus coordenadas se #encontrarán entre la de los extremos

def inSegment(P,s):
       A=s[0]
       B=s[1]
       sar=sarea(A,B,P)

       dAP=dist2(A,P) 
       dAB=dist2(A,B)
       dPB=dist2(P,B)
       if (sar == 0):
                    return (dAP<=dAB and dPB <= dAB)
       else:
                    return False
                    
    
def inTriangle(P,t):
    A=t[0]
    B=t[1]
    C=t[2]
    if (inSegment(P,[A,B]) or inSegment(P,[A,C]) or inSegment(P,[B,C])): #si está en la frontera pertenece al triángulo
                                                                       return True
    if(orientation(A,P,C)==orientation(C,P,B)==orientation(B,P,A)):
                                                                  return True;
    else:                                                         return False;
    

#metodo auxiliar para comprobar si un numero está en un intervalo,dónde num es un numero e I es el intervalo en forma de lista[numI,numF]
def isContained(num,I):
    #origen del intervalo
    ori=I[0]
    #final del intervalo
    en=I[1]
    return (num >= ori) and (num <= en)
    
    
    
def segmentIntersectionTest(a,b):
    
    #A,B,C,D son los extremos
    A=a[0]
    B=a[1]
    C=b[0]
    D=b[1]
    sABD=sarea(A,B,D)
    sABC=sarea(A,B,C)
    sCDA=sarea(C,D,A)
    sCDB=sarea(C,D,B)
   #Si todas las áreas signadas son ceros los puntos están sobre la misma recta
    if(sABD==0 and sABC ==0 and sCDA ==0 and sCDB ==0):
        return isContained(C[0],[A[0],B[0]])and isContained(C[1],[A[1],B[1]]);
   #comprobamos que ningún extremo de cualquiera de los dos segmentos esté en el otro (caso en el cúal una área signada valdría cero
    elif(inSegment(C,[A,B]) or inSegment(D,[A,B]) or inSegment(A,[C,D]) or inSegment(B,[C,D])):
        return True;
    else:
        return (sABD*sABC <0) and(sCDA*sCDB <0);
        
        
def lineIntersection(r,s):
    P1R=r[0]
    xP1R=P1R[0]
    yP1R=P1R[1]
    
    P2R=r[1]
    xP2R=P2R[0]
    yP2R=P2R[1]
    
    P1S=s[0]
    xP1S=P1S[0]
    yP1S=P1S[1]
    
    P2S=s[1]
    xP2S=P2S[0]
    yP2S=P2S[1]

    mR=(yP2R-yP1R)/(xP2R-xP1R)
    cR=yP2R-mR*xP2R
    mS=(yP2S-yP1S)/(xP2S-xP1S)
    cS=yP2S-mS*xP2S
    if(mS-mR ==0):
        print("Las lineas son paralelas")
        return -1
    x=(cR-cS)/(mS-mR)
    y=mS*x+cS
    return [x,y]
    
    
    
#incircle test. Entrada cuatro puntos a,b,c,d y salida 1, -1 o 0 dependiendo de que el punto d sea interior, exterior o este en la frontera del circulo que determinan a,b y c.

def inCircle(a,b,c,d):
   centro= circumcenter(a,b,c)
   radio=dist2(centro,a)
   dist=dist2(centro,d)
   if(dist < radio):
       return 1
   if(dist == radio):
       return 0
   else:
        return-1
        
               
def circumcenter(a,b,c):
    xa=a[0]
    ya=a[1]
    xb=b[0]
    yb=b[1]
    xc=c[0]
    yc=c[1]
  
    a=np.array([[xa,ya,1],[xb,yb,1],[xc,yc,1]])
    b=np.array([-pow(xa,2)-pow(ya,2),-pow(xb,2)-pow(yb,2),-pow(xc,2)-pow(yc,2)])
    [D,E,F]=np.linalg.solve(a, b)
    h=-D/2
    k=-E/2
    r=sqrt(pow(h,2)+pow(k,2))#este es el radio
    return [h,k]   
         
#PRACTICA 1

def min_index(lista):
    #devuelve el índice del mínimo en una lista de números
    longitud=len(lista)
    min=lista[0]
    index=0
    for i in range (0,longitud):
        if(min>lista[i]):
            min=lista[i]
            index=i
    return index 
    
    
def max_index(lista):
    #devuelve el índice del mínimo en una lista de números
    longitud=len(lista)
    max=lista[0]
    index=0
    for i in range (0,longitud):
        if(max<lista[i]):
            max=lista[i]
            index=i
    return index    
    
#Hallar el máximo / mínimo en abscisa / ordenada.
def maxAbcisa (lista):
    longitud=len(lista)
    maxA=lista[0][0]
    for i in range (0,longitud):
        if(maxA<lista[i][0]):
            maxA=lista[i][0]
    return maxA
    
    
def minAbcisa (lista):
    longitud=len(lista)
    minA=lista[0][0]
    for i in range (0,longitud):
        if(minA>lista[i][0]):
            
            minA=lista[i][0]
            
    return minA 
    
    
def maxOrdenada (lista):
    longitud=len(lista)
    maxO=lista[0][1]
    for i in range (0,longitud):
        if(maxO<lista[i][1]):
            maxO=lista[i][1]
    return maxO   
    
    
 def minOrdenada (lista):
    longitud=len(lista)
    minO=lista[0][1]
    for i in range (0,longitud):
        if(minO>lista[i][1]):
            minO=lista[i][1]
    return minO   
    
    
    
#2.Hallar el máximo / mínimo según una dirección dada por un vector.
def maxVector(listaP,vector):
    long=len (listaP)
    resList=[]
    a=0
    for i in range (0,long):
        a=np.dot(listaP[i],vector)
        resList.append(a)
    return listaP[max_index(resList)]
    
def minVector(listaP,vector):
    long=len (listaP)
    resList=[]
    a=0
    for i in range (0,long):
        a=np.dot(listaP[i],vector)
        resList.append(a)
    return listaP[min_index(resList)]    
    

#3.Si los puntos están en el primer cuadrante, hallar aquel cuyo
#vector de posición forma un ángulo máximo / mínimo con el eje de 
#abscisas.
    
def maxAngle(listaP):
    l=listaP
    longitud=len(listaP)
    for i in range (0,longitud):
        #comprobamos que todos los puntos están en el primer cuadrante

        if(listaP[i][0]<0):
            print("La x de al menos un punto es negativa, no está en el primer cuadrante")
            return -1
        if(listaP[i][1]<0):
             print("La y de al menos un punto es negativa, no está en el primer cuadrante")
             return -1
             
     #si estamos aquí es porque los puntos están en el primer cuadrante
     #normalizamos todos los puntos y el que esté más cerca de (0;1) es el de mayor ángulo
    listaDist=[]
    for i in range(0,longitud):
        modulo= sqrt(pow(l[i][0],2)+pow(l[i][1],2))
        puntoNorm=[(l[i][0]/modulo),(l[i][1]/modulo)]
        
        listaDist.append([dist(puntoNorm,[0,1])])#lista de distancias
       # print(listaDist[i])
     
    ind=min_index(listaDist)
   # print(ind)
         
    return l[ind]
    
        
def minOrIndex(listaP):
    lista=[]
    lista=listaP 
    longitud=len(lista)
    minO=lista[0][1]
    ind=0
    for i in range (0,longitud):
        #print (minO)
       # print(lista[i][1])
        if(minO > lista[i][1]):
            ind=i
            
           # print("Dentro del if")
           # print(ind)
            minO=lista[i][1]
   # print (minO)        
    return ind   
    
    
def maxOrIndex(listaP):
    lista=listaP
    longitud=len(lista)
    maxO=lista[0][1]
    ind = 0
    for i in range (0,longitud):
        if(maxO<lista[i][1]):
            ind = i
            maxO=lista[i][1]
    return ind    
    
 def ordAbcisas(listaP):
    #hacemos la ordenación ascendente de la lista con respecto a sus abcisas(de menor a mayor)
    lisRes=[]
    l=listaP #copiamos datos de entrada
    longitud=len(listaP)
    #print(l)
    for i in range (0,longitud):
        indice= minAbIndex(l)
        #print(indice)
        elemAInsertar=l[indice]
       # print(elemAInsertar)
        l.remove(elemAInsertar)
        lisRes.append(elemAInsertar)
    
    return lisRes
    
   
def ordOrdenadas(listaP):
    #hacemos la ordenación ascendente de la lista con respecto a sus ordenadas(de menor a mayor)
    lisRes=[]
    l=listaP #copiamos datos de entrada
    longitud=len(listaP)
    #print(l)
    for i in range (0,longitud):
        indice= minOrIndex(l)
        #print(indice)
        elemAInsertar=l[indice]
        #print(elemAInsertar)
        lisRes.append(elemAInsertar)
        l.remove(elemAInsertar)
        
    
    return lisRes    
    
    
def ordListVector(pointList,vector):
    listRes=[]
    for i in range (len(pointList)):
        elem=minVector(pointList,vector)
        listRes.append(elem)
        pointList.remove(elem)
    return listRes    
    
    
def isotetic(listaP):
    #función que devuelve los vértices del triangulo isotetico
    #punto de minima abcisa y minima ordenada--> vértice izquierdo abajo
    v1 = [listaP[minAbIndex(listaP)][0] ,listaP[minOrIndex(listaP)][1]]
    
    print (v1)
    #punto de maxima abcisa y mínima ordenada--> vértice derecho abajo
    v2 = [listaP[maxAbIndex(listaP)] [0],listaP[minOrIndex(listaP)][1]]
    
    print (v2)
    #punto de maxima ordenada y minima abcisa
    v3 = [listaP[minAbIndex(listaP)][0],listaP[maxOrIndex(listaP)][1]]
    
    print (v3)
     #punto de maxima ordenada y maxima abcisa
    v4 = [listaP[maxAbIndex(listaP)][0],listaP[maxOrIndex(listaP)][1]]
    
    print (v4)
    #si v1,v2,v3,v4 son vértices 
    #if(v1==v4 and v2==v4 and v2==v3 and v1==v3):
    return [v1,v2,v3,v4]    
    
    
    
def ordAbcisas(listaP):
    #hacemos la ordenación ascendente de la lista con respecto a sus abcisas(de menor a mayor)
    lisRes=[]
    l=listaP #copiamos datos de entrada
    longitud=len(listaP)
    #print(l)
    for i in range (0,longitud):
        indice= minAbIndex(l)
        #print(indice)
        elemAInsertar=l[indice]
       # print(elemAInsertar)
        l.remove(elemAInsertar)
        lisRes.append(elemAInsertar)
    
    return lisRes  
    
    
    
    
def ordOrdenadas(listaP):
    #hacemos la ordenación ascendente de la lista con respecto a sus ordenadas(de menor a mayor)
    lisRes=[]
    l=listaP #copiamos datos de entrada
    longitud=len(listaP)
    #print(l)
    for i in range (0,longitud):
        indice= minOrIndex(l)
        #print(indice)
        elemAInsertar=l[indice]
        #print(elemAInsertar)
        lisRes.append(elemAInsertar)
        l.remove(elemAInsertar)
        
    
    return lisRes
    
    
    
    
def angularSort(p,C):
    def compare(A,B):
        #ar=sarea(A,B,C)
        if A==B:
            return int (0)
        if A[1]== C[1] == B[1] :
            if C[0] <=A[0]<=B[0] or C[0] >= A[0] >= B[0]:
                return int (-1)
            if C[0] <= A[0] <= B[0] or C[0] >= A[0] >= B[0]:
                return int (1)
            if A[0] <= C[0] <= B[0]:
                return int (1)
            return int (-1)

        if A[1]>= C[1] > B[1] :
            return int (-1)
        if A[1]<C[1]<=B[1]:
            return int (1)
        if sarea(C,A,B) >0:
            return int (-1)
        if sarea (C,A,B):
            return int (1)
        if dist2(C,A) < dist2(C,B):
            return int (-1)
        return int (1)
        

    return sorted (p,cmp=compare)
    
#PRACTICA 3


def barycenter(a,b,c):
    x=(a[0]+b[0]+c[0])/3
    y=(a[1]+b[1]+c[1])/3
    return [x,y]    
    
# poligonizacion X-monotona

def polygonization(p):
    
    if (len(p)<3):
        print("No se puede poligonizar una lista de menos de 3 puntos")
        return -1
    
    min=0
    max=0
    min=minAbc(p)
    max=maxAbc(p)
    #print (min)
    #print (max)
    min= minAbc(p)
    max= maxAbc(p)
    s= p[min] # punto de minima abcisa del conjunto de puntos
    t= p[max] # punto de maxima abcisa del conjunto de puntos
    listSup=[]
    listInf=[]
    
    #metemos los puntos que esten en el segmento en la lista superior
    for i in range (0,len(p)):
      
       if( (inSegment(p[i],[s,t]) or sarea(s,p[i],t) >0) and (p[i]!=t)):
           #print("Estoy en el if")
           listSup.append(p[i])
       else :
           listInf.append(p[i])
    
    #listInf.append(s)
    #listSup.remove(s)
    #listInf.append(s)
    listSup= ordAbcisas(listSup)
    listInf= ordAbcisasNeg(listInf)
    
    
    listRes=[]
    for i in range (len(listSup)):
        listRes.append(listSup[i])
    for i in range (len(listInf)):
        listRes.append(listInf[i])
    listRes.append(listSup[0])
    
    #print listRes
    
    return listRes
    #return listRes.append(listInf[0])
    
    
# poligonizacion estrellada

def starPolygonization(p):
    if (len(p)<=2):
        print("Error")
        return -1
     
    listRes=[]
    listRes= angularSort(p,barycenter(p[0],p[1],p[2]))
    
    
    return listRes;    
    

def clipping(P,r):
    A=r[0]
    B=r[1]
    polList=[]
    if(sarea(A,P[0],B)<0):
        polList.append(P[0])

    for i in range(0,len(P)-1):
        if inClipping(A,P[i],B) and (not inClipping(A,P[i+1],B)):
            #polList.append(P[i+1])
            polList.append(lineIntersection(r,[P[i],P[i+1]]))
        elif not (inClipping(A,P[i],B)) and (inClipping(A,P[i+1],B)):
            polList.append(lineIntersection(r,[P[i],P[i+1]]))
            polList.append(P[i+1])
        elif (inClipping(A,P[i+1],B)):
            polList.append(P[i+1])
        
    if (sarea(A,P[0],B))*(sarea(A,P[len(P)-1],B)) <0:
        polList.append(lineIntersection(r,[P[0],P[len(P)-1]]))   

    return polList    
    
    
def earTest(P,i):
    lo=len(P)
    
    pos = P.index(i)
    for j in range(len(P)-1):
        if(sarea(i,P[(pos+1)%lo],P[(pos-1)%lo])>=0):
            return  True
        else:
            return False
    

# devolver el índice del vertice oreja
def ear(P):
    listIndex = []
    for i in range(len(P)-1):
        if earTest(P,P[i]) == True:
            listIndex.append(i)
    return listIndex
    
    
def updateList(list,i):
    #metodo auxiliar que permite actualizar la lista considerando el elemento de indice i cómo nueva cabeza
    #en caso de encontrar oreja ponemos el elemento de indice i+1 cómo cabeza y el i y anteriores al final
    listAux=[]
    longitud=len(list)
    lC=copy(list)
    listRes=[]
    ind=i
    for j in range (longitud):
        #ind % longitud
        listAux.append(list[(ind%longitud)])
        ind=ind+1
        
    return listAux
    
    
    
def otectomyTriangulation(P):
    ll=remove_duplicates(P)#quitamos vertices duplicados
    vertexList=[]
    longitud=len(P)
    n= len(ll)# numero de vertices en la figura
    while n >=3 :
        for i in range(n):
            if(earTest(ll,ll[(i%n)])):
               vertexList.append(ll[((i-1)%n)])
               vertexList.append(ll[((i+1)%n)])
               print(ll[i%n])
               ll.remove(ll[i%n])
               ll=updateList(ll,((i)%n))
               n=n-1
    return vertexList
    
    
def diagonal(p):
	diag=[]
	s=p[maxAbc(p)]
	d=0
	m=[]
	#print earTest(p,s)
	if(earTest(p,s)):
		return [p[len(p)-2],p[1]]
	else:
		for j in range (len(p)):
	dAux=0
	d=sarea(p[len(p)-1],p[j],p[1])
	if(pointInPolygon(p[j],[p[0],p[1],p[len-1]]) and d > dAux):
		m=p[j]
		dAux=sarea(p[len(p)-1],p[j],p[1])
	return [p[0],m]    
    
    
#PRACTICA 3


def convexhull(p):
    P=deepcopy(p)
    for i in Combinations(p,3):
        for j in P:
            if j not in i and inTriangle(j,i):
                if j in P:
                    P.remove(j)
    C=angularSort(P,P[0])                
    return C
    
    
def convexhull_edges(p):
    #convex hull de aristas
    P=deepcopy(p)
    C=[]
    CAux=[]
    for i in Combinations(P,2):
        aristaCC=True
        if p[0] not in i:
            A=p[0]
        elif p[1] not in i:
            A=p[1]
        else:
            A=p[2]
        signo=orientation(i[0],i[1],A)
    for j in p:
            if orientation(i[0],i[1],j)*signo <0:
                aristaCC=False
                continue
            if aristaCC:
                C+=[i[0],i[1]]
    C=angularSort(C,midPoint(c[0],c[1]))
    C=[C[2*i]for i in range(len(C)/2)]
    return C
    
    
def graham(p):
    P=deepcopy(p)
    p0=min(p)
    pp= angularSort(p,p[0])
    i=0
    l=len(pp)
    while i< l:
        if sarea(pp[i-1],pp[i],pp[(i+1)%l])<0:
            pp.pop(i)#borrar hay que reemplazarlo
            i=i-1
            l=l-1
        else:
            i=i+1
    return pp
    
    
#PRACTICA 4

# funcion que crea un DCEL, para un poligono
def dcel(P):
    n=len(P)
    V=[[P[i],i] for i in range(len(P))]
    e=[[i,n+i,(i-1)%n,(i+1)%n,1]for i in range(n)]+[[(i+1)%n,i,n+(i+1)%n,n+(i-1)%n,0]for i in range(n)]
    f=[n,0]
    return [V,e,f]

# funciones para referirse a los elementos asociados a un elemento del DCEL

# indice del origen de una arista e
def origin(e,D):
    return D[1][e][0]

# coordenadas del origen de la arista e
def originCoords(e,D):
    return D[0][origin(e,D)][0]

# arista gemela de la arista e    
def twin(e,D):
    return D[1][e][1]

# arista previa de la arista e    
def prev(e,D):
    return D[1][e][2]

# arista siguiente de la arista e    
def next(e,D):
    return D[1][e][3] 

# indice de la cara de cuyo borde forma parte la arista e    
def face(e,D):
    return D[1][e][4]               

# indice de una de las aristas del borde de la cara c
def edge(c,D):
    return D[2][c]
        
# funcion para dibujar las aristas de un DCEL

def plotDCEL(D):
    return sum(line([originCoords(i,D),originCoords(twin(i,D),D)],aspect_ratio=1) for i in range(len(D[1])))  
    
# funcion para colorear una cara de un DCEL

def plotFace(c,D,col):

    f=D[2][c]
    C=[f]
    f=next(f,D)
    while f <> C[0]:
        C.append(f)
        f=next(f,D)
    
    P=[originCoords(j,D) for j in C]
    return polygon(P,color=col, alpha=.5)     

# funcion para colorear las caras de un DCEL
    
def colorDCEL(D):
    return sum(plotFace(i,D,(random(),random(),random())) for i in range(1,len(D[2])))
    
    
# funcion para dividir una cara del DCEL D por una diagonal
# e1 y e2 son las aristas cuyos orígenes son los extremos de la diagonal que divide la cara

def splitFace(e1,e2,D):
    
    # si no son aristas de la misma cara o si son adyacentes sus origenes no definen una diagonal
    if face(e1,D) <> face(e2,D) or origin(e2,D) == origin(twin(e1,D),D) or origin(e1,D) == origin(twin(e2,D),D):
        print "no diagonal"
        return
    
    nv, ne, nf = len(D[0]), len(D[1]), len(D[2])
    preve1 = prev(e1,D)
    preve2 = prev(e2,D)
    k=face(e1,D)
    
    # añadimos las aristas nuevas
    D[1].append([origin(e1,D),ne+1,preve1,e2,k])
    D[1].append([origin(e2,D),ne,preve2,e1,nf])
    
    # modificamos aristas afectadas
    D[1][preve1][3]=ne
    D[1][e1][2]=ne+1
    D[1][preve2][3]=ne+1
    D[1][e2][2]=ne
    i=e1
    while i<>ne+1:
        D[1][i][4]=nf
        i=next(i,D)
    
    #modificamos la cara afectada
    D[2][k]=ne
    
    # añadimos la nueva cara
    D[2].append(ne+1)

def faceEdges(c,D):
    e=edge(c,D)
    aristas=[e]
    a=next(e,D)
    while a != aristas[0]:
        aristas.append(a)
        a=next(a,D)
    return aristas

def faceVertices(c,D):
    E=faceEdges(c,D)
    P=[origin(i,D) for i in E]
    return P

def faceVerticesCoords(c,D):
    E=faceEdges(c,D)
    P=[originCoords(i,D) for i in E]
    return P+[P[0]]

def faceNeighbors(c,D):
    E = faceEdges(c,D)
    N = [face(twin(i,D),D) for i in E]
    return N

def vertexEdges(v,D):
    F=[ D[0][v][1]]
    n=twin(prev(v,D),D)
    while n != F[0]:
        F.append(n)
        n=twin(prev(n,D),D)
    return F    
     
    
def vertexFan(v,D):
    E=vertexEdges(v,D)
    return [face(i,D) for i in E]

def graham(P):
    P = angularSortt(p)
    n = len(P)
    D = dcel(P)
    e = 2*n - 1                     #next(twin(0,D),D)
    while  twin(e,D) != 0 :
        if sarea(originCoords(e,D),originCoords(next(e,D),D),originCoords(next(next(e,D),D),D)) > 0:
            splitFace(e,next(next(e,D),D),D)
            e = prev(twin(prev(e,D),D),D)
           
        else:
             e = next(e,D)
        
    return D


def convexHullDCEL(D):
    e=edge(0,D)
    m=min(D[0])[0]
    actual=D[2][0]
    
    while originCoords(actual,D) != m:
        #print("in first while")
        
        e=next(e,D)
        actual=e
    #actual=next(actual,D)
    sig = next(actual, D)
    sigSig = next(sig, D)
    A = originCoords(actual,D)
    B = originCoords(sig,D)
    C = originCoords(sigSig,D)
    #print(actual, next(actual, D))
    #print("A = {}, B = {},\n C = {}, m = {}".format(A, B, C, m))
    #print(originCoords(next(next(actual,D),D),D),m)
    l = len(faceEdges(0,D))
    i = 0
    while i<l:   #originCoords(next(actual,D),D)!= m:
        #print("actual = {}".format(actual))
        
        ant=prev(actual,D)        
        sig = next(actual, D)
        sigSig = next(sig, D)
        A = originCoords(actual,D)
        #print("A =")
        #print(A)
        B = originCoords(sig,D)
        #print("B =")
        #print(B)
        C = originCoords(sigSig,D)
        #print("C =")
        #print(C)
        if sarea(A,B,C) > 0:
            #print("Splitface de")
            #print(e)
            #print(next(next(e,D),D),D)[0]
            splitFace(actual,next(next(actual,D),D),D)
            actual = ant
            #print("pasando a = {}".format(actual))
            i = i-1
            
        else:
            actual=next(actual,D)
            #print("pasando a = {}".format(actual))  
            i = i + 1
            
    return 0


def triangulation(p):
    C=min(p)
    
    def angularSort(p,C):
        def compare(A,B):
        #ar=sarea(A,B,C)
            if A==B:
                return int (0)
            if sarea(C,A,B) > 0:
                return int (-1)
            elif sarea(C,A,B) ==0 :

               if ( dist(C,A) < dist (C,B)):
                   return int (-1)
               else :
                    return int (1)
                    
            else:
                return int (1)
        return sorted (p,cmp=compare)
    pp = angularSort(p,C)
    D=dcel(pp)
    for i in range (len(pp)-2,1,-1):
        splitFace(0,i,D)
    convexHullDCEL(D)
    return D    


# Cuando se corten los segmentos la arista es flipable.
def flipable(a,D):
    at = twin(a,D)
    cara1 = face(a,D)
    cara2 = face(at,D)
    
    # Comprobar el cierre convexo.
    if cara1 == 0 or cara2 == 0:
        
        return false
    
    # Estos son los vertices de la arista a.
    p1 = originCoords(a,D)
    p2 = originCoords(at,D)
    
    # Estos son los vértices de los triangulos adyacentes a la arista a.
    p3 = originCoords(prev(a,D),D)
    p4 = originCoords(prev(at,D),D)
    
    
    return segmentIntersectionTest([p1,p2],[p3,p4])==1 or segmentIntersectionTest([p1,p2],[p3,p4])==0

def ilegal(a,D):
    # Una arista es legal si se puede girar.
    if not flipable(a,D):
        return false
    at = twin(a,D)
    # Estos son los vertices de la arista a.    
    p1 = originCoords(a,D)
    p2 = originCoords(at,D)
    
    # Estos son los vértices de los triangulos adyacentes a la arista a.
    p3 = originCoords(prev(a,D),D)
    p4 = originCoords(prev(at,D),D)
    
    if inCircle(p1,p2,p3,p4) == 1:
        return true
        
    return false

def legalize(T):
    tCopy = copy(T)
    quedan = [i for i in range(len(tCopy[1]))]
    while quedan:
        a = quedan.pop()
        if ilegal(a,tCopy) and flipable(a,tCopy):
            flip(a,tCopy)
            quedan = quedan+[prev(a,tCopy)]+[next(a,tCopy)]+[prev(twin(a,tCopy),tCopy)]+[next(twin(a,tCopy),tCopy)]
            #print(quedan)
    return tCopy


def delaunay(p):
    T = triangulation(p)
    return legalize(T)
