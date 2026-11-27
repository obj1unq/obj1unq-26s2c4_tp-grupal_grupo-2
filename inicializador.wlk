import vida.*
import wollok.game.*
import personajes.*
import direcciones.*
import mapa.*
import cosasEntorno.*
import administradorNiveles.*
import menu.*
import musica.*



object inicializador {

    var secuenciaPendiente = null

    const transicion = game.tick(
        1500,
        { self.ejecutarTransicion() },
        false
    )

    const animacionMovimientoGuerrero = game.tick(
        100,
        { guerrero.estado().avanzarFrame(guerrero) },
        false
    )

    const aparicionGoblins = game.tick(
        10000,
        {
            if (administradorNiveles.numeroNivelActual() < 3) {
                generadorGoblins.generar(0, guerrero)
            }
        },
        false
    )

    const animacionMovimientoGoblins = game.tick(
        100,
        {
            generadorGoblins.goblins().forEach({
                goblin => goblin.estado().avanzarFrame(goblin)
            })
        },
        false
    )

    const animacionJefe = game.tick(
        100,
        {
            if (administradorNiveles.numeroNivelActual() == 3) {
                jefeGoblin.estado().avanzarFrame(jefeGoblin)
            }
        },
        false
    )

    const movimientoGoblins = game.tick(
        1500,
        {
            generadorGoblins.goblins().forEach({
                goblin => goblin.perseguirGuerrero()
            })
        },
        false
    )

    const movimientoJefe = game.tick(
        1500,
        {
            if (administradorNiveles.numeroNivelActual() == 3) {
                jefeGoblin.perseguirGuerrero()
            }
        },
        false
    )

    const manzanasAleatorias = game.tick(
        18000,
        {
            if (administradorNiveles.numeroNivelActual() < 3) {
                generadorDeManzanas.generar(0, guerrero)
            }
        },
        false
    )

    const verificarCambioNivel = game.tick(
        500,
        { self.verificarAvance() },
        false
    )

    method verificarAvance() {
        if (administradorNiveles.numeroNivelActual() == 3 &&
            jefeGoblin.estaMuerto()) {

            secuenciaPendiente = imagenes4
            verificarCambioNivel.stop()
            transicion.start()
        }

        else if (generadorGoblins.puedeAvanzarNivel() &&
            administradorNiveles.haySiguienteNivel()) {

            secuenciaPendiente = secuencias.get(
                administradorNiveles.numeroNivelActual()
            )

            verificarCambioNivel.stop()
            transicion.start()
        }
    }

    method ejecutarTransicion() {
        transicion.stop()

        administradorNiveles.nivelActual().borrarMapa()

        generadorGoblins.reiniciar()
        generadorDeManzanas.reiniciar()
        generadorDePociones.reiniciar()
        generadorCrafteo.reiniciar()

        menu.cambiarPantalla(secuenciaPendiente)
        secuenciaPendiente = null
    }

    method iniciarTicks() {
        animacionMovimientoGuerrero.start()
        animacionMovimientoGoblins.start()
        movimientoGoblins.start()
        manzanasAleatorias.start()
        aparicionGoblins.start()
        verificarCambioNivel.start()
        animacionJefe.start()
        movimientoJefe.start()
    }

    method detenerTicks() {
        animacionMovimientoGuerrero.stop()
        aparicionGoblins.stop()
        animacionMovimientoGoblins.stop()
        movimientoGoblins.stop()
        manzanasAleatorias.stop()
        verificarCambioNivel.stop()
        animacionJefe.stop()
        movimientoJefe.stop()
    }

    method preparar() {
        administradorNiveles.nivelActual().dibujarMapa()
    }
    
    method configurarControles(){
        keyboard.e().onPressDo({ guerrero.interactuar() })
        keyboard.t().onPressDo({ guerrero.transformar() })

        keyboard.left().onPressDo({ guerrero.mover(izquierda) })
        keyboard.right().onPressDo({ guerrero.mover(derecha) })
        keyboard.up().onPressDo({ guerrero.mover(arriba) })
        keyboard.down().onPressDo({ guerrero.mover(abajo) })

        keyboard.space().onPressDo({ guerrero.atacar() })
    }
}