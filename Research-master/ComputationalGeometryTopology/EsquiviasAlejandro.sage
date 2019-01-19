#Libreria de Geometria Computacional

#PRACTICA 0


def dist(A,B):
    n1 = (B[0] - A[0]) ** 2
    n2 = (B[1] - A[1]) ** 2
    return math.sqrt(n1 + n2)
    
def dist2(A,B):
    n1 = (B[0] - A[0]) ** 2
    n2 = (B[1] - A[1]) ** 2
    return n1 + n2
    
def sarea(A,B,C):
    return 1/2*(((B[0]-A[0])*(C[1]-A[1]))-((B[1]-A[1])*(C[0]-A[0])))
    
def orientation(A,B,C):
    if sarea(A,B,C)>0 :
        #print ("Orientación positiva")
        return 1;#asignamos un 1 a orientación positiva
    else:
        #print("Orientación negativa")
        return 0;#asignamos un 0 a orientación negativa
        
def midPoint(A,B):
    return [(A[0] + B[0])/2, (A[1] + B[1])/2]
   
def inSegment1(P,s):
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
           
def inSegment(P,s):
        A = s[0]
        B = s[1]
        if A[0] <= P[0] <= B[0] and sarea(P,A,B) == 0:
            return true
        else:
            return false         
           
def inTriangle(P,t):
    A=t[0]
    B=t[1]
    C=t[2]
    if (inSegment(P,[A,B]) or inSegment(P,[A,C]) or inSegment(P,[B,C])): #si está en la frontera pertenece al triángulo
                                                                       return True
    if(orientation(A,P,C)==orientation(C,P,B)==orientation(B,P,A)):
                                                                  return true;
    else:                                                         return false;          
           
#metodo auxiliar para comprobar si un numero está en un intervalo,dónde num es un numero e I es el intervalo en forma de lista[numI,numF]
def isContained(num,I):
    #origen del intervalo
    ori=I[0]
    #final del intervalo
    en=I[1]
    return (num >= ori) and (num <= en)          
    
def segmentIntersectionTest1(a,b):
    
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
        return (sABD*sABC <0) and(sCDA*sCDB <0)          
           
def segmentIntersectionTest(a,b):
    Ar = a[0]
    Br = a[1]
    As = b[0]
    Bs = b[1]
    
    # Vectores directores de las rectas
    Vr = [Br[0]-Ar[0],Br[1]-Ar[1]]
    Vs = [Bs[0]-As[0],Bs[1]-As[1]]
    
    # Caso degenerado en el que las rectas son paralelas.        
    if Vr == Vs:
        print "Rectas paralelas"
        return false
    elif inSegment(Ar,b) or inSegment(Br,b) or inSegment(As,a) or inSegment(Bs,a):
        return true
    else:
        return true           
           
def lineIntersection1(r,s):
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
    
    #coeficiente director de r
    mR=(yP2R-yP1R)/(xP2R-xP1R)
    cR=yP2R-mR*xP2R
    
    #coeficiente director de s
    mS=(yP2S-yP1S)/(xP2S-xP1S)
    cS=yP2S-mS*xP2S
    if(mS-mR ==0):#caso de líneas paralelas
        print("Las lineas son paralelas")
        #devolvemos -1 porque es el caso de "error"
        return -1
    x=(cR-cS)/(mS-mR)
    y=mS*x+cS
    return [x,y]

def lineIntersection(r,s):
    # Puntos de las rectas
    Ar = r[0]
    Br = r[1]
    As = s[0]
    Bs = s[1]
    
    # Vectores directores de las rectas
    Vr = [Br[0]-Ar[0],Br[1]-Ar[1]]
    Vs = [Bs[0]-As[0],Bs[1]-As[1]]
    
    # Caso degenerado en el que las rectas son paralelas
    if Vr[0]/Vr[1] != Vs[0]/Vs[1]:
        x = (((Vs[1]*As[0]-Vs[0]*As[1])*(-Vr[0]))-((Vr[1]*Ar[0]-Vr[0]*Ar[1])*(-Vs[0])))/((Vr[1]*Vs[0])-(Vs[1]*Vr[0]))
        y = (-Vr[1]*x + Vr[1]*Ar[0]-Vr[0]*Ar[1])/(-Vr[0])
        return [x,y]
    else:
        print "Rectas paralelas"
        return 0           
           
def svolume(A,B,C,D):
    [Ax,Ay,Az] = A
    [Bx,By,Bz] = B
    [Cx,Cy,Cz] = C
    [Dx,Dy,Dz] = D
    Vs = (Cy*Dz-Cz*Dy)*Bx-(By*Dz-Bz*Dy)*Cx+(By*Cz-Bz*Cy)*Dx-(Cy*Dz-Cz*Dy)*Ax-(Ay*Cz-Az*Cy)*Dx+(Ay*Dz-Az*Dy)*Cx +(By*Dz-Bz*Dy)*Ax-(Ay*Dz-Az*Dy)*Bx+(Ay*Bz-Az*By)*Dx-(By*Cz-Bz*Cy)*Ax+(Ay*Cz-Az*Cy)*Bx-(Ay*Bz-Az*By)*Cx
    return Vs/6           
           
def inCircle(a,b,c,d):
    A = [a[0],a[1],(a[0]**2)+(a[1]**2)]
    B = [b[0],b[1],(b[0]**2)+(b[1]**2)]
    C = [c[0],c[1],(c[0]**2)+(c[1]**2)]
    D = [d[0],d[1],(d[0]**2)+(d[1]**2)]
    if(sarea(a,b,c)==0):
        return ("Tres puntos alineados no forman una circunferencia")
    elif(sarea(a,b,c)*svolume(A,B,C,D)<0):
        return 1 #esta en la circulo
    elif(sarea(a,b,c)*svolume(A,B,C,D)>0):
        return -1 #No esta en la circulo
    else:
        return 0 #Esta en la frontera del circulo           
           
#incircle test. Entrada cuatro puntos a,b,c,d y salida 1, -1 o 0 dependiendo de que el punto d sea interior, exterior o este en la frontera del circulo que determinan a,b y c.

def inCircle1(a,b,c,d):
    #calculamos el circuncentro (resuelto en la siguiente pregunta)
   centro= circumcenter(a,b,c)
   #como los tres puntos están sobre la frontera el radio²=dist2(centro,a)
   radio=dist2(centro,a)
   #calculamos la distancia del centro del círculo al punto d
   dist=dist2(centro,d)
   #si esta distancia es menor que el radio entonces d es interior
   if(dist < radio):
       return 1
       #si es igual al radio es frontera
   if(dist == radio):
       return 0
       #en otro caso es mayor que el radio y es exterior
   else:
        return-1           
           
import numpy as np
def circumcenter1(a,b,c):
    #circumcenter resuelto mediante sistema matricial
    #sacamos coordenadas x,y de los puntos a,b,c
    xa=a[0]
    ya=a[1]
    xb=b[0]
    yb=b[1]
    xc=c[0]
    yc=c[1]
  #construimos una matriz con los coeficientes D,E,F del círculo
    a=np.array([[xa,ya,1],[xb,yb,1],[xc,yc,1]])
    #b es el vector de resultados obtenido al pasar el término independiente de la ecuación del otro lado
    b=np.array([-pow(xa,2)-pow(ya,2),-pow(xb,2)-pow(yb,2),-pow(xc,2)-pow(yc,2)])
    #resolvemos con np.linalg.solve proporcionado por python
    [D,E,F]=np.linalg.solve(a, b)
    #h es la coordenada x del centro
    h=-D/2
    #k es la coordenada y del centro
    k=-E/2
    r=sqrt(pow(h,2)+pow(k,2))#este es el radio
    return [h,k]           
           
def circumcenter(a,b,c):
    
    # Caso degenerado, los tres puntos estÃ¡n en la misma recta.
    if inSegment(c,[a,b]) or inSegment(b,[a,c]) or inSegment(a,[b,c]):
        print "Tres puntos en la misma recta."
        return 0
    else:
                # Obtenemos el vector normal a los segmentos ab y bc.
        n1 = [(-b[1]+a[1]),(b[0]-a[0])]
        n2 = [(-c[1]+a[1]),(c[0]-a[0])] 
        n3=  [(-c[1]+b[1]),(c[0]-b[0])]
        # Calculamos los puntos medios de los segmento ab y bc.
        m1 = midPoint(a,b)
        m2= midPoint(a,c)
        m3 = midPoint(b,c)        
        
   
        
        # Encontramos las rectas r formada por el punto medio m1 y el vector normal, perpendicular al segmento ab, igual con la recta s.

        aux=[n1[0]+m1[0], n1[1] +m1[1]]
        aux2= [n2[0]+m2[0], n2[1] + m2[1]]
        # Calculamos la interseccion entre las rectas r y s.
        return lineIntersection([m1,aux],[m2,aux2])
                   
           
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
    
def maxAngle(listaP):
    #Si los puntos están en el primer cuadrante, hallar aquel cuyo vector de posición forma un ángulo máximo / mínimo con el eje de abscisas
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
    
def minAbIndex (listaP):
#devolvemos el índice del mínimo valor
    lista= listaP
    longitud=len(lista)
    minA=lista[0][0]
    ind=0
    for i in range (0,longitud):
        if(minA>lista[i][0]):
            #print(minA,lista[i][0])
                ind = i
                minA=lista[i][0]
    return ind    
    
def maxAbIndex (listaP):
    #devolvemos el índice del valor máximo
    lista=listaP
    longitud=len(lista)
    maxA=lista[0][0]
    ind=0
    for i in range (0,longitud):
        if(maxA<lista[i][0]):
            ind=i
            maxA=lista[i][0]
    return ind    
        
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
    
def divList(pointList,pend):
    niu=pointList#copia de la lista puntos
    n=len(pointList) #numero de puntos
    lisAux=[]#lista auxiliar creada a vacio
       #caso de una recta vertical
    if (pend == infinity): 
        #ordenamos teniendo en cuenta la coordenada x --> la de las abcisas
        lisAux = ordAbcisas(pointList)
        if(n %2 ==0):#es par
            print("Traza una recta vertical entre las abcisas ")
            print(lisAux[(n/2)-1][0] , lisAux[(n/2)+1][0])
            return 0;# terminación correcta
        #caso de una recta vertical
        else:#es impar
            c=(int)(n/2)
            print("Traza la recta x= ")
            print(lisAux[c][0])
            return 0

    if(pend==0):
        #ordenamos teniendo en cuenta la coordenada y --> la de las ordenadas
        lisAux= ordOrdenadas(pointList)
        if(n %2 ==0):#es par
            print("Traza una recta horizontal entre las ordenadas ")
            #print(lisAux[(n/2)-1][1] , lisAux[(n/2)+1][1])
            return [lisAux[(n/2)-1][1] , lisAux[(n/2)+1][1]];# terminación correcta
        #caso de una recta vertical
        else:#es impar
            c=(int)(n/2)
            print("Traza la recta y= ")
            print(lisAux[c][1])
            return 0
      
    else:
        # en otro caso de pendiente

        Cy=[1,pend]
        Cx=[pend,-1]
        listUp=ordListVector(niu,Cx)
        if(n %2 ==0):#es par
            print(" Traza la recta de pendiente "+str(pend)+" entre los puntos")
            #print(listUp[int((n/2)-1)][1] , listUp[int((n/2)+1)][1])
            return [listUp[int((n/2)-1)] , listUp[int((n/2)+1)]];# terminación correcta
        #caso de una recta vertical
        else:#es impar
            c=(int)(n/2)
            print("Traza la recta de pendiente "+str(pend)+" pasando por el punto")
            #print(listUp[c])
            return listUp[c]#terminación correcta    
    
def isotetic(listaP):
    #función que devuelve los vértices del triangulo isotetico
    #punto de minima abcisa y minima ordenada--> vértice izquierdo abajo
    v1 = [listaP[minAbIndex(listaP)][0] ,listaP[minOrIndex(listaP)][1]]
    
    #print (v1)
    #punto de maxima abcisa y mínima ordenada--> vértice derecho abajo
    v2 = [listaP[maxAbIndex(listaP)] [0],listaP[minOrIndex(listaP)][1]]
    
    #print (v2)
    #punto de maxima ordenada y minima abcisa
    v3 = [listaP[minAbIndex(listaP)][0],listaP[maxOrIndex(listaP)][1]]
    
    #print (v3)
     #punto de maxima ordenada y maxima abcisa
    v4 = [listaP[maxAbIndex(listaP)][0],listaP[maxOrIndex(listaP)][1]]
    
    #print (v4)
    #si v1,v2,v3,v4 son vértices 
    #if(v1==v4 and v2==v4 and v2==v3 and v1==v3):
    return [v1,v2,v3,v4]    
    
def ordListVector(pointList,vector):
    listRes=[]
    for i in range (len(pointList)):
        elem=minVector(pointList,vector)
        listRes.append(elem)
        pointList.remove(elem)
    return listRes
    
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
    
##PRACTICA 3


def ordAbcisas1(p):
    def compare(a,b):
        if a[0]<b[0]:
            return int(-1)
        return int(1)
    return sorted(p, cmp = compare)


def polygonization(p):
    pp = ordAbcisas1(p)
    if (len(pp)<3):
        print("No se puede poligonizar una lista de menos de 3 puntos")
        return -1    
    
    s= pp[0] # punto de minima abcisa del conjunto de puntos
    t= pp[-1] # punto de maxima abcisa del conjunto de puntos
    listSup=[]
    listInf=[s]
    
    
    #metemos los puntos que esten en el segmento en la lista superior
    
    for i in pp:
       if i not in [s,t]:
           if(sarea(s,i,t) >= 0):
           
               listInf.append(i)
           else :
               listSup.append(i)
    
    
    #listSup= ordAbcisas1(listInf)
    #listInf= ordAbcisas1(listSup)
    
    
    listSup.append(t)
    aux=listSup
    listSup.reverse()
    
    
       
    listRes=listInf + listSup
    
    #print(listInf[0]+listSup[-1])
    return listRes+[listInf[0]]+[listSup[-1]]    
    
def barycenter(a,b,c):
    x=(a[0]+b[0]+c[0])/3
    y=(a[1]+b[1]+c[1])/3
    return [x,y]

def starPolygonization(p):
    if (len(p)<=2):
        print("Error")
        return -1
    listRes=[]
    listRes= angularSort(p,barycenter(p[0],p[1],p[2]))
    return listRes;    
    
# Método auxiliar para determinar si un vértice del polígono esta en la parte izquierda o no de la recta.
def inClipping(A,B,C):
    return sarea(A,B,C) <=0    
    
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
    
def kernel(p):
    #Nucleo de un poligono
    C=copy(p)
    for i in range(len(p)):
        C=clipping(C,[p[i-1],p[i]])
    return C    
        
### funcion auxiliar que detecta si un vertice es oreja en tiempo O(n)    
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
    
def remove_duplicates(lista):
    # Inicialmente copio todos los elementos y luego borro los repes
    sin_repes = lista
    
    for i in lista:
        if lista.count(i) > 1:
            sin_repes.remove(i)
            # Quito al repe, y vulvo a llamar a la funcion con la nueva lista
            remove_duplicates(sin_repes)
    return sin_repes

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
               #print(ll[i%n])
               ll.remove(ll[i%n])
               ll=updateList(ll,((i)%n))
               n=n-1
    return vertexList    
    
def pointInPolygon(Q,p):
    # Partimos del polígono ordenado.
    i = 0
    j = len(p)-1
    inside = False
    # Se considera que los puntos de la frontera del polígono no     son puntos interiores.
    for i in range(len(p)):
    # Comprobamos la proxiidad del punto respecto el polígono.
        if (p[i][1] < Q[1] and p[j][1] >= Q[1]) or (p[j][1] < Q[1] and p[i][1] >= Q[1]):
# Comprobamos si el punto esta en el interior del polígono teniendo encuenta las coordenadas x e y.
             if p[i][0] + (Q[1] - p[i][1])/(p[j][1] - p[i][1])*(p[j][0]-p[i][0]) < Q[0]:
                inside = not inside
        j = i
    return inside    
    
#funciones auxiliares cortesía de Daniel Gómez Barroso
def min_by(list, index):
    m = list[0][index]
    lista = []
    for i in range (len(list)):
        if list[i][index] < m:
            lista = [i]
            m = list[i][index]
        elif list[i][index] == m:
            lista.append(i)
    return lista

def max_by(list, index):
    m = list[0][index]
    lista = []
    for i in range (len(list)):
        if list[i][index] > m:
            lista = [i]
            m = list[i][index]
        elif list[i][index] == m:
            lista.append(i)
    return lista

def maxY(puntos):
    return max_by(puntos,1)
    
def minY(puntos):
    return min_by(puntos,1)

def maxX(puntos):
    return max_by(puntos,0)
    
def minX(puntos):
    return min_by(puntos,0)    
    
def maxAbc(lista):
    #Función cortesía de Andrea del Nido
    ind=0
    max=lista[0][0]
    for i in range (len(lista)):
        if lista[i] [0] > max :
            ind = i
            max= lista [i][0]
        elif lista [i][0] == max and lista [i][1] < lista [ind][1]:
            ind = i
            max =lista[i][0]
    #Devolvemos el indice
    return ind

def diagonal1(p):
    #esta función diagonal no es correcta
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
           
#Dado un polígono, hallar una diagonal interna en tiempo lineal
def diagonal(p):
    l = len(p)
    pos = maxX(p)[0]
    P = p[pos]
    A = p[(pos-1)]
    B = p[(pos+1)%l]
    
    
    puntos = []
    for i in range(l):
        if p[i] not in [A,B,P]:
            
            if (inTriangle(p[i],[A,P,B])>0):
                puntos.append([i,sarea(A,p[i],B)])
                
    
    if (len(puntos)==0):
        return [((pos-1)%l),((pos+1)%l)]
     
    else:
        
        P2 = max_by(puntos, 1)[0]
        return [pos, puntos[P2][0]]   
        
        
#PRACTICA 3


def convexhull(p):
    P=deepcopy(p)
    for i in Combinations(p,3):
        for j in P:
            if j not in i and inTriangle(j,i):
                if j in P:
                    P.remove(j)
    C=angularSort(P,midPoint(P[0],P[1]))                
    return C               
        
def convexhull_edges(p):
    P = []
    for i in Combinations(p,2):
        points = copy(p)
        points.remove(i[0])
        points.remove(i[1])
        s = sarea(i[0],i[1],points[0])
        cambia = true
        for j in points:
            if cambia:
                cambia= (orientation(i[0],i[1],j)*s >= 0)
           
        if cambia:
            if i[0] not in P:
                P.append(i[0])
            if i[1] not in P:
                P.append(i[1])
    cent = barycenter(P[0],P[1],P[2])
    pol = angularSort(P,cent)                
    return pol   
    
def jarvis(p):
    initial=min(p)
    C=[initial]
    endPoint=initial
    sig=p[0]
    if(p[0]==initial):
        sig=p[1]

    while(initial!=sig):
            sig=p[0]
    
            if(p[0]==endPoint):
                sig=p[1]
            for i in range (len(p)):
                
                if (sarea(endPoint,sig,p[i])<0):
                    sig=p[i]
       
            endPoint=sig
            C.append(endPoint)
    return C    
    
def graham(p):
    P=deepcopy(p)
    p0=min(p)
    pp= angularSort(p,midPoint(p[0],p[1]))
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
    
#FUNCIONES AUXILIARES NECESARIAS EN QUICKHULL
def superiores (P, p0, p1):
    if (len(P) == 0):
        return []
    p = []
    new1 = maxSarea(P,p0,p1)
    pIzq = []
    pDcha = []
    for i in P:
        if (sarea(p0,new1,i) > 0):
            pIzq.append(i)
        elif (sarea(new1,p1,i) > 0):
            pDcha.append(i)
    
    if (sarea(p0,p1,new1)) > 0:
        p.append(new1)
        for i in P:
            if (sarea(p0,new1,i) > 0):
                pIzq.append(i)
            elif (sarea(new1,p1,i) > 0):
                pDcha.append(i)
        if len(pIzq)>0:
            p = p + (superiores(pIzq,p0,new1))
        if len(pDcha)>0:
            p = p +(superiores(pDcha,new1,p1))
    
    return p

def maxSarea (P, p0, p1):
    max = P[0]
    
    value = sarea(p0, p1, max)
    for i in P:
        s = sarea(p0, p1, i)
        if (s > value):
            max = i
            value = s
    return max
    
def inferiores (P, p0, p1):
    if (len(P) == 0):
        return []
    p = []
    new1 = maxSarea(P,p1,p0)
    pIzq = []
    pDcha = []
    if (sarea(p0,p1,new1)) < 0:
        p.append(new1)
        for i in P:
            if (sarea(p1,new1,i) > 0):
                pDcha.append(i)
            elif (sarea(new1,p0,i) > 0):
                pIzq.append(i)
    
        if len(pIzq)>0:
            p = p +(inferiores(pIzq,p0,new1))
        if len(pDcha)>0:
            p = p +(inferiores(pDcha,new1,p1))
        
    return p
    
#QUICKHULL
def quickHull(p):
    min = p[minX(p)[0]]
    max = p[maxX(p)[0]]
    pInf = []
    pSup = []
    
    for i in p:
        s = sarea(min, max, i)
        if s > 0:
            pSup.append(i)
        elif s < 0:
            pInf.append(i)
    
    sup = superiores(pSup,min,max)
    inf = inferiores(pInf,min,max)

    return angularSort(([min,max]+sup+inf),(midPoint(min,max)))    
    
    
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
    
    # aÃ±adimos las aristas nuevas
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
    
    # aÃ±adimos la nueva cara
    D[2].append(ne+1)    
    
#de forma auxiliar definimos esta funcion que numera los vertices del dcel
def plotDCELNum(D):
    #función auxiliar que permite numerar los puntos en un dcel
    P=[]
    G=plot([0,0])
    #G=[]
    #print("ploteo el 0")
    for i in range (len(D[0])):
        #print("in for")
        P.append(D[0][i][0])
        
        
        #print("ploteo el {}".format(D[0][i][0]))
        #G=G+text(D[0][i][1],P[i])
        G += text('  (%s)'%(D[0][i][1]),D[0][i][0],horizontal_alignment='left',color='red')+point([D[0][i][0]])+sum(line([originCoords(i,D),originCoords(twin(i,D),D)],aspect_ratio=1) for i in range(len(D[1]))) 
    G.show(figsize=12,xmin=D[0][0][0][0])    
    
def faceEdges(c,D):
    e=edge(c,D)
    
    aristas=[e]
    a=next(e,D)
    while e != a:
        aristas.append(a)
        a=next(a,D)
    return aristas    
    
def faceVertices(c,D):
    edges = faceEdges(c,D)
    solution = [origin(i,D) for i in edges]
    return solution    
    
def faceVerticesCoords(c,D):
    edges = faceEdges(c,D)
    coords = [originCoords(i,D) for i in edges]
    return coords    
    
def faceNeighbors1(c,D):
    #implementación de Daniel Gómez 
    aristas = faceEdges(c,D)
    gemelas = [twin(i,D) for i in aristas]
    vecinas = []
    for i in gemelas:
        cara = face(i,D)
        if (len(vecinas) == 0) or (vecinas[-1] != cara):
            vecinas.append(cara)
    
    if vecinas[0] == vecinas[-1]:
        vecinas.pop(-1)
    return vecinas    
    
def faceNeighbors(c,D):
    #implementacion propia
    edges = faceEdges(c,D)
    neighbors = [face(twin(i,D),D) for i in edges]
    return list(set( neighbors ))    
     
    
def vertexEdges(v,D):
    indices = [D[0][v][1]]
    n = twin(prev(v,D),D)
    while n != indices[0]:
        indices.append(n)
        n = twin(prev(n,D),D)
    return indices    
    
def vertexFan(v,D):
    edges = vertexEdges(v,D)
    return [face(i,D) for i in edges]    

def convexHullDCEL(D):
    #con ayuda de Daniel Gómez Barroso    
    primer = edge(0,D)    
    minimo = min(D[0])[0]
    while originCoords(primer,D) != minimo :
        primer = next(primer,D)  
    
    actual = primer
    longitud = len(faceEdges(0,D))
    i = 0
    while (i < longitud):     
        ant = prev(actual,D)
        sig = next(actual, D)
        sigSig = next(sig, D)
        A = originCoords(actual,D)
        B = originCoords(sig,D)
        C = originCoords(sigSig,D)
        if (sarea(A,B,C) > 0):
            splitFace(actual,sigSig,D)
            actual = ant
            i = i-1
        else:
            actual = sig
            i = i+1        
    sig = next(actual, D)
    sigSig = next(sig, D)
    A = originCoords(actual,D)
    B = originCoords(sig,D)
    C = originCoords(sigSig,D)
    if (sarea(A,B,C) > 0):
        splitFace(actual,sigSig,D)
        actual = prev(actual,D)
    else:
        actual = sig
    
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
    
    
#PRACTICA 5    
     
    
#Funcion auxiliar proporcionada por Manuel Abellanas para "flipar"aristas
def flip(a,D):
    oa=D[1][a][0]
    ga=D[1][a][1]
    ca=D[1][a][4]
    aa=D[1][a][2]
    pa=D[1][a][3]
    cb=D[1][ga][4]
    ab=D[1][ga][2]
    pb=D[1][ga][3]
    oga=D[1][ga][0]
    D[1][a]=[D[1][aa][0],ga,pa,ab,ca]
    D[1][ga]=[D[1][ab][0],a,pb,aa,cb]
    D[1][pa][2]=ab
    D[1][pa][3]=a
    D[1][aa][2]=ga
    D[1][aa][3]=pb
    D[1][aa][4]=cb
    D[1][pb][2]=aa
    D[1][pb][3]=ga
    D[1][ab][2]=a
    D[1][ab][3]=pa
    D[1][ab][4]=ca
    D[2][ca]=a
    D[2][cb]=ga
    D[0][oa][1]=pb
    D[0][oga][1]=pa

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
    
    
    return segmentIntersectionTest([p1,p2],[p3,p4])    
    
def ilegal(a,D):
    # Una arista es ilegal se tiene que poder girar.
    if flipable(a,D) == false:
        return false
    at=twin(a,D)
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
        if not legal(a,tCopy):
            quedan = quedan + [prev(a,tCopy),next(a,tCopy),prev(twin(a,tCopy),tCopy),next(twin(a,tCopy),tCopy)]
            flip(a,tCopy)
    return tCopy 
def legal(a,D):
    if (not (flipable(a,D))):
        return True
    
    b = twin(a,D)
    A,B,C = originCoords(a,D), originCoords(next(a,D), D), originCoords(prev(a,D), D)
    E = originCoords(prev(b,D), D)
    if ((inCircle(A,B,C,E)) <= 0):
        return True
    else: 
        return False        
        
def legalize(T):
    #legalize hecho por Daniel Gómez Barroso
    tCopy = copy(T)
    quedan = [i for i in range(len(tCopy[1]))]
    while quedan:
        a = quedan.pop()
        if not legal(a,tCopy):
            quedan = quedan + [prev(a,tCopy),next(a,tCopy),prev(twin(a,tCopy),tCopy),next(twin(a,tCopy),tCopy)]
            flip(a,tCopy)
    return tCopy
    
def legalize1(T):
    #implementacion propia hecha con ilegal
    tCopy = copy(T)
    quedan = [i for i in range(len(tCopy[1]))]
    while quedan:
        a = quedan.pop()
        if ilegal(a,tCopy):
            quedan = quedan + [prev(a,tCopy),next(a,tCopy),prev(twin(a,tCopy),tCopy),next(twin(a,tCopy),tCopy)]
            flip(a,tCopy)
    return tCopy

def delaunay(p):
    #hecho con legalize
    T = triangulation(p)
    return legalize(T)
    
def delaunay1(p):
    #hecho con legalize1
    T = triangulation(p)
    return legalize1(T)
    
 
#PRACTICA 6


def Normalize(A):
    #función realizada por Daniel Gómez Barroso
    norm = dist([0,0], A)
    return [i/norm for i in A]


def voronoiRegion(v,D,R):
    #función realizada por Daniel Gómez Barroso
    puntos = vertexEdges(v,D)
    aristas = vertexEdges(v,D)
    vertices = []
    for i in range(len(aristas)):
        if face(aristas[i],D) == 0:# SI la arista actual es una arista exterior
            p1, p2 = originCoords(aristas[i],D), originCoords(next(aristas[i],D),D)
            p0 = midPoint(p1,p2)
            vNormal = [p1[1]-p2[1], p2[0]-p1[0]]
            vNormalized = Normalize(vNormal)
            vLargo = [vNormalized[0]*50, vNormalized[1]*50]
            vertices.append([p0[0]+vLargo[0],p0[1]+vLargo[1]])
        
        elif face(twin(aristas[i],D),D) == 0: #Si la gemela de la actual es una arista exterior
            p1, p2 = originCoords(aristas[i],D), originCoords(next(aristas[i],D),D)
            p0 = midPoint(p1,p2)
            vNormal = [p2[1]-p1[1], p1[0]-p2[0]]
            vNormalized = Normalize(vNormal)
            vLargo = [vNormalized[0]*50, vNormalized[1]*50]
            vertices.append([p0[0]+vLargo[0],p0[1]+vLargo[1]])
            
            p0,p1,p2 = D[0][v][0], originCoords(prev(aristas[i],D),D), originCoords(next(aristas[i],D),D)
            vertices.append(circumcenter(p0,p1,p2))
        else:
            p0,p1,p2 = D[0][v][0], originCoords(prev(aristas[i],D),D), originCoords(next(aristas[i],D),D)
            
            vertices.append(circumcenter(p0,p1,p2))
    return vertices 
 
#función realizada por Daniel Gómez Barroso
def Voronoi(p):
    D = delaunay(p)
    
    regiones = [voronoiRegion(i,D,0) for i in range(len(D[0]))]
    return regiones 
 
 
 
 
 
 
    
               
