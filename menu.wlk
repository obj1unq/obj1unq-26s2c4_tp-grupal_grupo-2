
import wollok.game.*
import inicializador.*
import personajes.*
import musica.*
import administradorNiveles.*

// --------------------------------
// ELEMENTOS VISUALES
// --------------------------------

class Menu {
  var property image
  var property position
}

const botonStart        = new Menu(image = "boton_start.png", position = game.at(5, 5))
const botonControles    = new Menu(image = "boton_controles.png", position = game.at(5, 3))
const fondoMenu         = new Menu(image = "fondo_menu.png", position = game.origin())
const pantallaControles = new Menu(image = "pantalla_controles.png", position = game.origin())
const pantallaGameOver = new Menu(image = "pantalla_game_over.png", position = game.origin())
const fondoNivel2 = new Menu(image = "fondo2.jpg", position = game.origin())
const fondoNivel3 = new Menu(image = "fondo3.jpg", position = game.origin())

// --------------------------------
// CLASE PADRE
// --------------------------------

class Pantalla {
  method mostrar()

  method ocultar()

  method confirmar()

  method volver()

  method abrirControles()

  method detectarMuerte()

}
// --------------------------------
// SECUENCIA DE IMAGENES
// --------------------------------




class SecuenciaImagen inherits Pantalla {

    var imagenInicial = 1
    const property cantImagenes
    const property musica
    const property prefijoImagen
    const property puedeAvanzarNivel
    var imagenActual = null

    override method mostrar() {
        musica.empezarMusica()
        self.mostrarImagen()
    }

    method mostrarImagen() {
        self.verificarImagenActual()

        const nombreImagen = prefijoImagen + imagenInicial + ".png"

        imagenActual = new Menu(image = nombreImagen, position = game.origin())

        game.addVisual(imagenActual)
    }

    method verificarImagenActual(){
      if (imagenActual != null) {
            game.removeVisual(imagenActual)
        }
    }

    override method confirmar() {
        if (imagenInicial < cantImagenes) {
            self.siguienteImagen()
        }
        else {
            self.siguienteNivel()
        }
    }

    method siguienteImagen(){
      imagenInicial += 1
      self.mostrarImagen()
    }

    method siguienteNivel(){
      imagenInicial = 1
      if (puedeAvanzarNivel) {
        administradorNiveles.avanzarNivel()
      }
      menu.cambiarPantalla(juego)
    }


    override method ocultar() {
        musica.pararMusica()

        if (imagenActual != null) {
            game.removeVisual(imagenActual)
            imagenActual = null
        }
    }

    override method volver() {}
    override method abrirControles() {}
    override method detectarMuerte() {}
}

class SecuenciaImagenFinal inherits SecuenciaImagen {

  override method confirmar() {
      if (imagenInicial < cantImagenes) {
          imagenInicial += 1
          self.mostrarImagen()
      }
      else {
          musica.pararMusica()
          game.stop()
      }
  }
}

// --------------------------------
// PANTALLA PRINCIPAL
// --------------------------------

class MenuPrincipal inherits Pantalla {

  override method mostrar() {
    game.addVisual(fondoMenu)
    game.addVisual(botonStart)
    game.addVisual(botonControles)
  }

  override method ocultar() {
    game.removeVisual(fondoMenu)
    game.removeVisual(botonStart)
    game.removeVisual(botonControles)
  }

  override method confirmar() {
    musicaMenu.pararMusica()
    menu.cambiarPantalla(imagenes1)
  }

  override method abrirControles() {
    menu.cambiarPantalla(controles)
  }

  override method volver() {}

  override method detectarMuerte() {}

}


// --------------------------------
// PANTALLA DE CONTROLES
// --------------------------------

class Control inherits Pantalla {

  override method mostrar() {
    game.addVisual(pantallaControles)
  }

  override method ocultar() {
    game.removeVisual(pantallaControles)
  }

  override method confirmar() {
    self.volver()
  }

  override method volver() {
    menu.cambiarPantalla(menuPrincipal)
  }

  override method abrirControles() {}

  override method detectarMuerte() {}

}


// --------------------------------
// PANTALLA DE JUEGO
// --------------------------------

class Juego inherits Pantalla {

  override method mostrar() {
    inicializador.preparar()
    administradorNiveles.nivelActual().empezarMusica()
    inicializador.iniciarTicks()
    menu.iniciarDeteccionGameOver()
  }

  override method ocultar() {
    administradorNiveles.nivelActual().pararMusica()
    inicializador.detenerTicks()
    menu.detenerDeteccionGameOver()
  }

  override method confirmar() {}

  override method volver() {}

  override method abrirControles() {}

  override method detectarMuerte() {
    if (guerrero.estaMuerto()) {
      musicaGameOver.empezarMusica()
      menu.cambiarPantalla(gameOver)
    }
  }

}


// --------------------------------
// PANTALLA GAME OVER
// --------------------------------

class GameOver inherits Pantalla {

  override method mostrar() {
    game.addVisual(pantallaGameOver)
  }

  override method ocultar() {
    game.removeVisual(pantallaGameOver)
  }

  override method confirmar() {
    musicaGameOver.pararMusica()
    game.stop()
  }

  override method volver() {
}

  override method abrirControles() {}

  override method detectarMuerte() {}

}


// --------------------------------
// OBJETOS CONCRETOS
// --------------------------------

const menuPrincipal = new MenuPrincipal()
const controles     = new Control()
const juego         = new Juego()
const gameOver      = new GameOver()

const imagenes1 = new SecuenciaImagen(cantImagenes = 13, musica = musicaImagen1, prefijoImagen = "imagen_1_", puedeAvanzarNivel = false)

const imagenes2 = new SecuenciaImagen(cantImagenes = 13, musica = musicaImagen2, prefijoImagen = "imagen_2_", puedeAvanzarNivel = true)

const imagenes3 = new SecuenciaImagen(cantImagenes = 21, musica = musicaImagen3, prefijoImagen = "imagen_3_", puedeAvanzarNivel = true)

const imagenes4 = new SecuenciaImagenFinal(cantImagenes = 7, musica = musicaGanador, prefijoImagen = "imagen_4_", puedeAvanzarNivel = false)

const secuencias = [imagenes1, imagenes2, imagenes3, imagenes4]

// --------------------------------
// GESTOR DE PANTALLAS
// --------------------------------

object menu {

  var pantallaActual = menuPrincipal
  var fondoNivelActual = null
  const detectarGameOver = game.tick(1300, { self.detectarMuerte() }, false)

  method mostrar() {
    game.width(15)
    game.height(11)
    game.cellSize(50)
    game.title("Orc Slayer")

    inicializador.configurarControles()


    musicaMenu.empezarMusica()

    pantallaActual.mostrar()

    keyboard.enter().onPressDo({ self.confirmar() })
    keyboard.c().onPressDo({ self.abrirControles() })
    keyboard.m().onPressDo({ self.volver() })
  }

  method cambiarPantalla(nuevaPantalla) {
    pantallaActual.ocultar()
    pantallaActual = nuevaPantalla
    pantallaActual.mostrar()
  }

  method confirmar() {
    pantallaActual.confirmar()
  }

  method abrirControles() {
    pantallaActual.abrirControles()
  }

  method volver() {
    pantallaActual.volver()
  }

  method detectarMuerte() {
    pantallaActual.detectarMuerte()
  }

  method iniciarDeteccionGameOver() {
    detectarGameOver.start()
  }

  method detenerDeteccionGameOver() {
    detectarGameOver.stop()
  }
  method cambiarFondoNivel(numeroNivel) {
    if (fondoNivelActual != null) {
      game.removeVisual(fondoNivelActual)
    }
    if (numeroNivel == 2) {
      fondoNivelActual = fondoNivel2
      game.addVisual(fondoNivelActual)
    } else {
      fondoNivelActual = fondoNivel3
      game.addVisual(fondoNivelActual)
      }
    }
}
