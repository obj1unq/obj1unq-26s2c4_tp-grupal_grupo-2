import wollok.game.*
import inicializador.*
import personajes.*



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

object pantallaGameOver {
  method image() = "pantalla_game_over.png"
  method position() = game.origin()
}

object menu {
  var property pantallaActual = "menu"
  const detectarGameOver = game.tick(100, { menu.detectarMuerte() }, false)

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
    self.menu()
    self.controles()
  }

  method menu(){
    if (pantallaActual == "menu") {
        menu.iniciarJuego()
    }
  }

  method controles(){
    if (pantallaActual == "controles") {
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
    detectarGameOver.start()
  }

  method detectarMuerte() {
    if (pantallaActual == "juego") {
      if (guerrero.vida() <= 0) {
        self.mostrarGameOver()
      }
    }
  }

  method mostrarGameOver() {
    pantallaActual = "gameOver"

    inicializador.detenerTicks()

    game.addVisual(pantallaGameOver)
    //keyboard.r().onPressDo({ menu.reintentar() })
    keyboard.m().onPressDo({ menu.volverMenuPrincipal() })
  }

  method volverMenuPrincipal() {
    if (pantallaActual == "gameOver") {
      game.removeVisual(pantallaGameOver)

      pantallaActual = "menu"

      game.addVisual(fondoMenu)
      game.addVisual(botonStart)
      game.addVisual(botonControles)
    }
  }

}
