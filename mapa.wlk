import personajes.*
import cosasEntorno.*
import direcciones.*
import vida.*

class Nivel {
    const property mapa
    var visuals = []

    method construirVisuals() {
        visuals = []
        pv.reiniciar()

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
        self.construirVisuals()

        visuals.forEach({ visual =>
            game.addVisual(visual)
        })

        gg.redibujar()
    }

    method ancho() {
        return mapa.anyOne().size()
    }

    method alto() {
        return mapa.size()
    }
}


const nivel1 = new Nivel(
    mapa = [
        [aa,aa,aa,aa,aa,aa,aa,aa,aa,aa,aa,aa,aa,aa,aa],
        [aa,pv,pv,pv,pv,pv,pv,pv,pv,pv,pv,pv,pv,pv,aa],
        [aa,pv,p2,__,__,p3,__,__,__,aa,__,__,p1,pv,aa],
        [aa,pv,__,__,__,__,__,p2,__,__,__,__,__,pv,aa],
        [aa,pv,p3,__,__,gg,__,__,__,__,__,aa,__,pv,aa],
        [aa,pv,__,__,aa,__,__,__,__,__,__,__,__,pv,aa],
        [aa,pv,__,__,__,__,__,__,__,aa,__,__,p2,pv,aa],
        [aa,pv,p1,__,__,__,__,p1,__,__,aa,__,__,pv,aa],
        [aa,pv,pv,pv,pv,pv,pv,pv,pv,pv,pv,pv,pv,pv,aa],
        [aa,aa,aa,aa,aa,aa,aa,aa,aa,aa,aa,aa,aa,aa,aa],
        [ll,cc,cc,cc,cc,cc,cc,__,__,__,__,i1,i2,i3,i4]
    ].reverse()
)

//const nivel2 = new Nivel(
//    mapa = [
//        // Acá va la matriz del segundo mapa
//    ].reverse()
//)

object aa {
    method crearVisual(position) {
        return new Pino(image = "pino.png", position = position)
    }
}

object __ {
    method crearVisual(position) {
        return null
    }
}

object gg {
    method crearVisual(position) {
        guerrero.position(position)
        return null
    }

    method redibujar() {
        game.addVisual(guerrero)
        guerrero.redibujar()
    }
}

object p1 {
    method crearVisual(position) {
        return new Piedra(image = "roca1_1.png", position = position)
    }
}

object p2 {
    method crearVisual(position) {
        return new Piedra(image = "roca1_2.png", position = position)
    }
}

object p3 {
    method crearVisual(position) {
        return new Piedra(image = "roca1_3.png", position = position)
    }
}

object ll {
    method crearVisual(position) {
        return new Logo(image = "personaje.png", position = position)
    }
}

object cc {
    var indice = 0
    var proximaPosicion = 7

    method crearVisual(position) {
        indice += 1
        return new Corazon(position = position, indice = indice)
    }

    method agregarCorazon() {
        indice += 1
        game.addVisual(new Corazon(
            position = game.at(proximaPosicion, 0),
            indice = indice
        ))
        proximaPosicion += 1
    }

    method reiniciar() {
        indice = 0
        proximaPosicion = 7
    }
}

object pv {
    const posiciones = #{}

    method crearVisual(position) {
        posiciones.add(position)
        return null
    }

    method posiciones() {
        return posiciones
    }

    method posicionRandom() {
        return posiciones.anyOne()
    }

    method reiniciar() {
        posiciones.clear()
    }
}
