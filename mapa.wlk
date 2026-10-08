import personajes.*
import cosasEntorno.*
import direcciones.*

object nivel{
    const jugador = guerrero
    const mapa = [//0,1,2,3,4,5,6,7,8,9 
                   [a,a,a,a,a,a,a,a,a,a],
                   [a,_,p2,_,_,_,_,_,_,a],
                   [a,_,_,_,p3,_,_,_,_,a],
                   [a,_,_,_,_,_,_,p2,_,a],
                   [a,p2,_,_,_,_,_,_,d,a],
                   [a,_,_,_,_,_,a,_,_,a],
                   [a,_,_,_,_,_,_,_,_,a],
                   [a,_,_,_,_,_,_,p1,_,a],
                   [a,g,p1,_,_,_,_,_,_,a],
                   [a,a,a,a,a,a,a,a,a,a],
                   [l,c,c,c,c,c,c,c,c,c]
                ].reverse()

    //    const fila = [p,m,_,_,_,_,m]


    method dibujarMapa(){
        (0..self.alto()-1).forEach({ y => self.dibujarFila(mapa.get(y), y)})
        g.redibujar()
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



object a{
    method poner(position){
        game.addVisual(new Imagen(image = "pino.png", position = position))
    }
}

object _{
    method poner(position){

    }
}

object g{
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
        game.addVisual(new Imagen(image = "roca1_1.png", position = position))
    }
}

object p2{
    method poner(position){
        game.addVisual(new Imagen(image = "roca1_2.png", position = position))
    }
}

object p3{
    method poner(position){
        game.addVisual(new Imagen(image = "roca1_3.png", position = position))
    }
}

object d{
    method poner(position){
        goblin.position(position)
        game.addVisual(goblin)
    }
}

object l {
    method poner(position){
        game.addVisual(new Imagen(image = "personaje.png", position = position))
    }
}

object c {
    method poner(position){
        game.addVisual(new Imagen(image = "corazon_lleno_transparente.png", position = position))
    }
}