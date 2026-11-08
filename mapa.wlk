import personajes.*
import cosasEntorno.*
import direcciones.*
import vida.*

object nivel{
    const property posicionesPosiblesIzquierda = #{game.at(1,2), game.at(1,3), game.at(1,4), game.at(1,5), game.at(1,6), game.at(1,7), game.at(1,8), game.at(1,9)}
    const property posicionesPosiblesAbajo     = #{game.at(2,2), game.at(3,2), game.at(4,2), game.at(5,2), game.at(6,2), game.at(7,2), game.at(8,2), game.at(9,2), game.at(11,2), game.at(12,2)}
    const property posicionesPosiblesDerecha   = #{game.at(11,9), game.at(10,9), game.at(9,9), game.at(8,9), game.at(7,9), game.at(6,9), game.at(5,9), game.at(4,9), game.at(3,9)}
    const property posicionesPosiblesArriba    = #{game.at(13,3),game.at(13,4),game.at(13,5),game.at(13,6),game.at(13,7),game.at(13,8),game.at(13,9)}
    const jugador = guerrero
    
    var property visuals = []

    const mapa = [//0,1,2,3,4,5,6,7,8,9 
                   [a,a,a,a,a,a,a,a,a,a,a,a,a,a,a],
                   [a,_,_,_,_,_,_,_,_,_,_,_,_,_,a],
                   [a,_,p2,_,_,p3,_,_,_,a,_,_,p1,_,a],
                   [a,_,_,_,_,_,_,p2,_,_,_, _,_,_,a],
                   [a,_,p3,_,_,g,_,_,_,_,_,a,_,_,a],
                   [a,_,_,_,_,_,a,_,_,_,_,_,_,_,a],
                   [a,_,_,_,_,_,_,_,_,a,_,_,p2,_,a],
                   [a,_,p1,_,_,_,_,p1,_,_,a,_,_,_,a],
                   [a,_,_,_,_,_,_,_,_,_,_,_,_,_,a],
                   [a,a,a,a,a,a,a,a,a,a,a,a,a,a,a],
                   [l,c,c,c,c,c,c,_,_,_,_,i1,i2,i3,i4]
                ].reverse()

    //    const fila = [p,m,_,_,_,_,m]


    method construirVisuals() {
        visuals = []

        (0..self.alto()-1).forEach({ y =>
        self.construirFila(mapa.get(y), y)
        })
    }

    method construirFila(fila, y) {
        (0..self.ancho()-1).forEach({ x =>
        const visual = fila.get(x).crearVisual(game.at(x, y))
    
        if (visual != null) {
          visuals.add(visual)
        }
        })
    }
    
    method dibujarMapa() {
      visuals.forEach({ visual =>
        game.addVisual(visual)
      })
    
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
    method crearVisual(position){
        return new Pino (image = "pino.png", position = position)
    }
}

object _{
    method crearVisual(position){
        return null
    }
}

object g {
    method crearVisual(position){
        guerrero.position(position)
        return null
    }

    method redibujar(){
        guerrero.redibujar()
    }
}

object p1{
    method crearVisual(position){
        return new Piedra(image = "roca1_1.png", position = position)
    }
}

object p2{
    method crearVisual(position){
        return new Piedra(image = "roca1_2.png", position = position)
    }
}

object p3{
    method crearVisual(position){
        return new Piedra(image = "roca1_3.png", position = position)
    }
}

object l {
    method crearVisual(position){
        return new Logo(image = "personaje.png", position = position)
    }
}

object c {
    var indice = 0
    var proximaPosicion = 7

    method crearVisual(position) {
      indice += 1

      return new Corazon(
      position = position,
      indice = indice
      )
    }

    method agregarCorazon() {
      indice += 1

      game.addVisual(
        new Corazon(
        position = game.at(proximaPosicion, 0),
        indice = indice
      )
      )

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




