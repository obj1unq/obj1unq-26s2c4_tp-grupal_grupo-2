import vida.*
import wollok.game.*
import personajes.*
import direcciones.*
import mapa.*
import cosasEntorno.*
import administradorNiveles.*


object inicializador {

    const animacionMovimientoGuerrero = game.tick(
        100,
        { guerrero.estado().avanzarFrame(guerrero) },
        false
    )

    const aparicionGoblins = game.tick(
        10000,
        { generadorGoblins.generar(0, guerrero) },
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

    const movimientoGoblins = game.tick(
        1500,
        {
            generadorGoblins.goblins().forEach({
                goblin => goblin.perseguirGuerrero()
            })
        },
        false
    )

    const manzanasAleatorias = game.tick(
        22500,
        { generadorDeManzanas.generar(0, guerrero) },
        false
    )

    method iniciarTicks() {
        animacionMovimientoGuerrero.start()
        animacionMovimientoGoblins.start()
        movimientoGoblins.start()
        manzanasAleatorias.start()
        aparicionGoblins.start()
    }

    method detenerTicks() {
        animacionMovimientoGuerrero.stop()
        aparicionGoblins.stop()
        animacionMovimientoGoblins.stop()
        movimientoGoblins.stop()
        manzanasAleatorias.stop()
    }

    method preparar() {
        administradorNiveles.nivelActual().dibujarMapa()

        inventarios.agregarElementoCraft(espada, guerrero)
        inventarios.agregarElementoCraft(collar, guerrero)
        inventarios.agregarElementoCraft(botas, guerrero)
        inventarios.agregarElementoCraft(lingote, guerrero)

        keyboard.e().onPressDo({ guerrero.interactuar() })
        keyboard.t().onPressDo({ guerrero.transformar() })

        keyboard.left().onPressDo({ guerrero.mover(izquierda) })
        keyboard.right().onPressDo({ guerrero.mover(derecha) })
        keyboard.up().onPressDo({ guerrero.mover(arriba) })
        keyboard.down().onPressDo({ guerrero.mover(abajo) })

        keyboard.space().onPressDo({ guerrero.atacar() })
    }
}