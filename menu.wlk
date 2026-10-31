import wollok.game.*
import inicializador.*


object botonStart {
  method image() = "boton_start.png"
  method position() = game.at(5, 5)
}

object botonControles {
  method image() = "boton_controles.png"
  method position() = game.at(5, 3)
}

object fondoMenu {
  method image() = "fondo_menu.png"
  method position() = game.origin()
}

object pantallaControles {
  method image() = "pantalla_controles.png"
  method position() = game.origin()
}

object menu {
  var property pantallaActual = "menu"

  method mostrar() {
    game.width(15)
    game.height(11)
    game.cellSize(50)
    game.title("Goblin Slayer")
    game.boardGround("fondo1.jpg")

    pantallaActual = "menu"

    game.addVisual(fondoMenu)
    game.addVisual(botonStart)
    game.addVisual(botonControles)

    keyboard.enter().onPressDo({ menu.confirmar() })
    keyboard.c().onPressDo({ menu.abrirControles() })
  }

  method confirmar() {
    if (pantallaActual == "menu") {
      menu.iniciarJuego()
    } else {
      menu.volverMenu()
    }
  }

  method abrirControles() {
    if (pantallaActual == "menu") {
      pantallaActual = "controles"

      game.removeVisual(fondoMenu)
      game.removeVisual(botonStart)
      game.removeVisual(botonControles)

      game.addVisual(pantallaControles)
    }
  }

  method volverMenu() {
    game.removeVisual(pantallaControles)

    pantallaActual = "menu"

    game.addVisual(fondoMenu)
    game.addVisual(botonStart)
    game.addVisual(botonControles)
  }

  method iniciarJuego() {
    pantallaActual = "juego"

    game.removeVisual(fondoMenu)
    game.removeVisual(botonStart)
    game.removeVisual(botonControles)

    inicializador.preparar()
    inicializador.iniciarTicks()
  }
}
