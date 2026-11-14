
import wollok.game.*
import inicializador.*
import personajes.*

// --------------------------------
// ELEMENTOS VISUALES
// --------------------------------

class Menu {
  var property image
  var property position
}

const botonStart = new Menu(image = "boton_start.png", position = game.at(5, 5))
const botonControles = new Menu(image = "boton_controles.png", position = game.at(5, 3))
const fondoMenu = new Menu(image = "fondo_menu.png", position = game.origin())
const pantallaControles = new Menu(image = "pantalla_controles.png", position = game.origin())
const pantallaGameOver = new Menu(image = "pantalla_game_over.png", position = game.origin())
const fondoNivel2 = new Menu(image = "fondo2.jpg", position = game.origin())


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
    menu.cambiarPantalla(juego)
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
    inicializador.iniciarTicks()
    menu.iniciarDeteccionGameOver()
  }

  override method ocultar() {
    inicializador.detenerTicks()
    menu.detenerDeteccionGameOver()
  }

  override method confirmar() {}

  override method volver() {}

  override method abrirControles() {}

  override method detectarMuerte() {
    if (guerrero.vida() <= 0) {
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

  override method confirmar() {}

  override method volver() {
    menu.cambiarPantalla(menuPrincipal)
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
    game.boardGround("fondo1.jpg")

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
    }
  }
}
