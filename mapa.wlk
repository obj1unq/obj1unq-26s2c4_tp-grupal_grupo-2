import personajes.*
import cosasEntorno.*
import direcciones.*

object nivel{
    const jugador = guerrero
    const mapa = [//0,1,2,3,4,5,6,7,8,9 
                   [a,a,a,a,a,a,a,a,a,a],
                   [a,_,_,_,_,_,_,p,_,a],
                   [a,_,_,_,p,_,_,_,_,a],
                   [a,_,_,_,_,_,_,p,_,a],
                   [a,p,_,_,_,_,_,_,d,a],
                   [a,_,_,g,_,_,p,_,_,a],
                   [a,_,_,_,_,_,_,_,_,a],
                   [a,_,_,_,_,_,_,p,_,a],
                   [a,_,p,_,_,_,_,_,_,a],
                   [a,a,a,a,a,a,a,a,a,a]
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
        game.addVisual(new Arbol(position = position))
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

object p{
    method poner(position){
        game.addVisual(new Piedra(position = position))
    }
}

object d{
    method poner(position){
        goblin.position(position)
        game.addVisual(goblin)
    }
}