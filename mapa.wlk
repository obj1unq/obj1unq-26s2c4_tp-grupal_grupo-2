import personajes.*
import cosasEntorno.*
import direcciones.*
import vida.*

object nivel{
    
    const mapa = [//0,1,2,3,4,5,6,7,8,9 
                   [aa,aa,aa,aa,aa,aa,aa,aa,aa,aa,aa,aa,aa,aa,aa],
                   [aa,pv,pv,pv,pv,pv,pv,pv,pv,pv,pv,pv,pv,pv,aa],
                   [aa,pv,p2,__,__,p3,__,__,__,aa,__,__,p1,pv,aa],
                   [aa,pv,__,__,__,__,__,p2,__,__,__,__,__,pv,aa],
                   [aa,pv,p3,__,__,gg,__,__,__,__,__,aa,__,pv,aa],
                   [aa,pv,__,__,__,__,aa,__,__,__,__,__,__,pv,aa],
                   [aa,pv,__,__,__,__,__,__,__,aa,__,__,p2,pv,aa],
                   [aa,pv,p1,__,__,__,__,p1,__,__,aa,__,__,pv,aa],
                   [aa,pv,pv,pv,pv,pv,pv,pv,pv,pv,pv,pv,pv,pv,aa],
                   [aa,aa,aa,aa,aa,aa,aa,aa,aa,aa,aa,aa,aa,aa,aa],
                   [ll,cc,cc,cc,cc,cc,cc,__,__,__,__,i1,i2,i3,i4]
                ].reverse()

    //    const fila = [p,m,_,_,_,_,m]


    method dibujarMapa(){
        (0..self.alto()-1).forEach({ y => self.dibujarFila(mapa.get(y), y)})
        gg.redibujar()
    }

    method ancho(){
        return mapa.anyOne().size()
        //return mapa.get(0).size()
        //return mapa.head().size()
        //return mapa.last().size()
    }

    method alto(){
        return mapa.size()
    }

    method dibujarFila(fila,y){
        (0..self.ancho()-1).forEach({ x => fila.get(x).poner(game.at(x,y)) })
    }

    method configurarTablero(){
    	game.title("Juego")
	    game.height(self.alto())
	    game.width(self.ancho())
	    game.cellSize(50)
	    game.boardGround("fondo1.jpg")
    }

}



object aa{

    method poner(position){
        game.addVisual(new Pino(image = "pino.png", position = position))
    }

}

object __{

    method poner(position){

    }
    
}

object gg {

    method poner(position){
        guerrero.position(position)
        game.addVisual(guerrero)
    }

    method redibujar(){
        guerrero.redibujar()
    }
    
}

object p1{

    method poner(position){
        game.addVisual(new Piedra(image = "roca1_1.png", position = position))
    }
    
}

object p2{

    method poner(position){
        game.addVisual(new Piedra(image = "roca1_2.png", position = position))
    }
    
}

object p3{

    method poner(position){
        game.addVisual(new Piedra(image = "roca1_3.png", position = position))
    }
    
}

object ll {

    method poner(position){
        game.addVisual(new Logo(image = "personaje.png", position = position))
    }
    
}

object cc {

    var indice = 0
    var proximaPosicion = 7

    method poner(position) {
        indice += 1
        game.addVisual(new Corazon(position = position, indice = indice))
    }

    method agregarCorazon() {
        indice += 1
        game.addVisual(new Corazon(position = game.at(proximaPosicion, 0), indice = indice))
        proximaPosicion += 1
    }

    method reiniciar() {
        indice = 0
        proximaPosicion = 7
    }
    
}

object m {

    method poner(position){
        game.addVisual(new Manzana(image = "manzana.png", position = position))
    }
    
}

object pv{

    const posiciones = #{}

    method poner(position){
        posiciones.add(position)
    }

    method posiciones(){
        return posiciones
    }
    method posicionRandom(){
        return posiciones.anyOne()
    }
}