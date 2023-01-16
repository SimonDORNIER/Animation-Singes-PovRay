#include "shapes.inc"
#include "colors.inc"
#include "textures.inc"
#include "woods.inc"
#include "glass.inc"
#include "metals.inc"
#include "functions.inc" 
#include "stones1.inc"
#include "skies.inc"

#declare Pi = 3.1415926535897932384626;
#declare ciel=1;
#declare sca=3;

// axes
#declare Font="cyrvetic.ttf"
#declare O3=<0,0,0>;
#declare I=<1,0,0>;
#declare J=<0,1,0>;
#declare K=<0,0,1>;
#declare rCyl=0.025;
#declare rCone=0.075;

camera {
        location <3, 12, 1.2>
        look_at <3, 0, 1.2>
        sky <0, 0, 1> // pour avoir le Z en haut
        right <-image_width/image_height,0,0> // pour un repere direct
} // Fin camera

// Initialisation des lumieres
light_source {<9, 12, 7> color White}
light_source {<-3, 12, 7> color White}
light_source {<0, 0, -3> color White}

background {White}

global_settings {
        max_trace_level 60//32*3
        ambient_light 1.00
        assumed_gamma 2.0
} // Fin global_settings

#if (ciel)
    sky_sphere {S_Cloud5 rotate <90,0.051, 1>}
#end

#macro flecheDiffuseNom(G,H,Coul,alph,rCyl,rCon,diffu,text1,sca,rot,trans)
   #local H1 = G + alph* (H-G);
   union {
      union {
         cylinder {
            G, H1, rCyl
         }
         cone {
            H1, rCon
            H , 0
         }
      }
      text {
         ttf "timrom.ttf"  text1
	 0.1, 0  
         scale sca 
         rotate rot
         translate trans   
      } 
      pigment {color Coul}
      finish {diffuse diffu}
   }// fin union
#end // fin macro fleche

//sca,rot,trans
flecheDiffuseNom(O3,I,Red,0.75,rCyl,rCone,1,"X",0.35,<90,0,0>,<0.5,0,0.125>)
flecheDiffuseNom(O3,J,Green,0.75,rCyl,rCone,1,"Y",0.35,<90,0,-45>,<0.0,0.75,0.1250>)
flecheDiffuseNom(O3,K,Blue,0.75,rCyl,rCone,1,"Z",0.35,<90,0,180>,<-0.20,0.0,0.750>)

plane {
   -z 150
   pigment{
      brick rgbt<1.0,1.,1.0,0.250>, rgbt<0.750,.5,0.0,0.850>  
      mortar 5 brick_size 125   
   } // Fin pigment	
   rotate <0,0,45>
} // Fin plane

#macro matelas (Z, h2, k, lX, lY)
        #local A = <k, k, Z>;
        #local B = <lX-k, k, Z>;
        #local C = <lX-k, lY-k, Z>;
        #local D = <k, lY-k, Z>;
        #local h1 = h2 - k;
        merge {
                box {
                        A <C.x, C.y, C.z+h2>
                } // Fin box
                merge {
                        merge {
                                merge {
                                        merge {
                                                sphere {
                                                        <A.x,A.y,A.z+h1> k
                                                } // Fin sphere
                                                sphere {
                                                        <B.x,B.y,B.z+h1> k
                                                } // Fin sphere
                                        } // Fin merge
                                        merge {
                                                sphere {
                                                        <C.x,C.y,C.z+h1> k
                                                } // Fin sphere
                                                sphere {
                                                        <D.x,D.y,D.z+h1> k
                                                } // Fin sphere
                                        } // Fin merge
                                } // Fin merge
                                merge {       
                                        merge {       
                                                box {
                                                        <A.x, A.y-k, A.z>
                                                        <B.x, B.y+k, B.z+h1>
                                                } // Fin box       
                                                box {
                                                        <B.x+k, B.y, B.z>
                                                        <C.x-k, C.y, C.z+h1>
                                                } // Fin box
                                        } // Fin merge       
                                        merge {       
                                                box {
                                                        <C.x, C.y+k, C.z>
                                                        <D.x, D.y-k, D.z+h1>
                                                } // Fin box       
                                                box {
                                                        <D.x-k, D.y, D.z>
                                                        <A.x+k, A.y, A.z+h1>
                                                } // Fin box
                                        } // Fin merge
                                } // Fin merge
                        } // Fin merge
                        merge {
                                merge {
                                        merge {
                                                cylinder {
                                                        A <A.x,A.y,A.z+h1> k
                                                } // Fin cilinder
                                                cylinder {
                                                        B <B.x,B.y,B.z+h1> k
                                                } // Fin cilynder
                                        } // Fin merge
                                        merge {
                                                cylinder {
                                                        C <C.x,C.y,C.z+h1> k
                                                } // Fin cylinder
                                                cylinder {
                                                        D <D.x,D.y,D.z+h1> k
                                                } // Fin cylinder
                                        } // Fin merge
                                } // Fin merge
                                merge {
                                        merge {       
                                                cylinder {
                                                        <A.x,A.y,A.z+h1>
                                                        <B.x,B.y,B.z+h1>
                                                        k
                                                } // Fin cylinder        
                                                cylinder {
                                                        <B.x,B.y,B.z+h1>
                                                        <C.x,C.y,C.z+h1>
                                                        k
                                                } // Fin cylinder
                                        } // Fin merge  
                                        merge {       
                                                cylinder {
                                                        <C.x,C.y,C.z+h1>
                                                        <D.x,D.y,D.z+h1>
                                                        k
                                                } // Fin cylinder        
                                                cylinder {
                                                        <D.x,D.y,D.z+h1>
                                                        <A.x,A.y,A.z+h1>
                                                        k
                                                } // Fin cylinder
                                        } // Fin merge
                                } // Fin merge
                        } // Fin merge
                } // Fin merge
                pigment {color Gray}
        } // Fin merge
#end // Fin macro <matelas>

merge { // Lit
        #local zSom = 0.5;
        #local hSom = 0.1;    
        #local xLit = 7;
        #local yLit = 3;
        merge { 
                box { // Sommier
                        <0, 0, zSom>
                        <xLit, yLit, zSom+hSom>
                } // Fin box
                merge { // Pieds du lit
                        merge {  
                                merge { // Pied 1
                                        #local G1 = <0.1, 0, 0>;
                                        lathe {
                                                bezier_spline 4
                                                <G1.x, G1.y>
                                                <0.15, -0.05>
                                                <0.15, -0.15>
                                                <0.05, -0.25>
                                        } // Fin lathe
                                        lathe {
                                                bezier_spline 4
                                                <G1.x, G1.y>
                                                <0.15, 0.05>
                                                <0.15, 0.15>
                                                <0.1, 0.25>
                                        } // Fin lathe
                                        rotate <90, 0, 0>
                                        translate <0.5, 0.5, 0.25>
                                } // Fin merge
                                merge { // Pied 2
                                        #local G1 = <0.1, 0, 0>;
                                        lathe {
                                                bezier_spline 4
                                                <G1.x, G1.y>
                                                <0.15, -0.05>
                                                <0.15, -0.15>
                                                <0.1, -0.25>
                                        } // Fin lathe
                                        lathe {
                                                bezier_spline 4
                                                <G1.x, G1.y>
                                                <0.15, 0.05>
                                                <0.15, 0.15>
                                                <0.05, 0.25>
                                        } // Fin lathe
                                        rotate <90, 0, 0>
                                        translate <6.5, 0.5, 0.25>
                                } // Fin merge
                        } // Fin merge
                        merge {  
                                merge { // Pied 3
                                        #local G1 = <0.1, 0, 0>;
                                        lathe {
                                                bezier_spline 4
                                                <G1.x, G1.y>
                                                <0.15, -0.05>
                                                <0.15, -0.15>
                                                <0.05, -0.25>
                                        } // Fin lathe
                                        lathe {
                                                bezier_spline 4
                                                <G1.x, G1.y>
                                                <0.15, 0.05>
                                                <0.15, 0.15>
                                                <0.1, 0.25>
                                        } // Fin lathe
                                        rotate <90, 0, 0>
                                        translate <6.5, 2.5, 0.25>
                                } // Fin merge
                                merge { // Pied 4
                                        #local G1 = <0.1, 0, 0>;
                                        lathe {
                                                bezier_spline 4
                                                <G1.x, G1.y>
                                                <0.15, -0.05>
                                                <0.15, -0.15>
                                                <0.05, -0.25>
                                        } // Fin lathe
                                        lathe {
                                                bezier_spline 4
                                                <G1.x, G1.y>
                                                <0.15, 0.05>
                                                <0.15, 0.15>
                                                <0.1, 0.25>
                                        } // Fin lathe
                                        rotate <90, 0, 0>
                                        translate <0.5, 2.5, 0.25>
                                } // Fin merge
                        } // Fin merge
                } // Fin merge
                pigment {color Brown}
        } // Fin merge
        matelas (zSom+hSom, 0.6, 0.2, xLit, yLit)
} // Fin merge

#declare singe = blob {   
  threshold 1.0       // décimal          //Singe
              
                            
    sphere {                            //Corps
        <0,0,0>     //Centre
        2         //Rayon  
        strength 1.1         //Force
        pigment { rgb <0.6,0.2,0.2> }
        scale <1,1.2,1.15> 
        rotate <0,0,45>
        translate <0,0,0>
    }   
    sphere {                            //Bras droit
        <0,0,0>     
        0.15         
        1          
        //pigment { color Brown }
        scale <2.3,-0.7,-0.7>   
        rotate <0,45,-22.5>
        translate <0.58,-0.2,-0.05>
    }     
    sphere {                            //Bras gauche
        <0,0,0>     
        0.15          
        1          
        //pigment { color Brown }
        scale <-0.7,2.3,-0.7>   
        rotate <-50,0,30>
        translate <-0.36,0.5,-0.05>
    }
    cylinder {                          //Pied gauche
        <0,0,0>      // 2 extrémitées
        <0.15,0,0>    
        0.15           //Rayon   
        1
        //pigment { rgb<0,1,0> } 
        scale <1,1.1,-0.4>   
        rotate <0,0,80>
        translate <-0.1,0.15,-0.465>
    } 
    cylinder {                          //Pied Droit 
        <0,0,0>      
        <0.15,0,0>    
        0.15             
        1
        //pigment { rgb<0,1,0> } 
        scale <1,1.1,-0.4>   
        rotate <0,0,40>
        translate <0.15,-0.07,-0.465>
    }                  

       
     
    
        
     
  translate <1,1,1>
  sturm      // booléen
  hierarchy // booléen    
    
} 

#macro Saut2(clk)
	
	sin (X2)
#end

#declare Time = clock +0.00;
object { singe
	texture {
		pigment{color rgb<0.3,0.7,0>}
		finish{phong 1}
	}
	translate
		<1, 1, sin(clock*pi)+0.7>
} // end sphere
object { singe
	texture {
		pigment{color rgb<0.3,0.7,0>}
		finish{phong 1}
	}
	translate
		<3, 1, sin(clock+1)+0.7>
} // end sphere