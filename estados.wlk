
class Estado {
    const nombre
    const puedeMover
    const puedeAtacar
    const maxFramesEstado

    method nombre() {
        return nombre
    }

    method puedeMover() {
        return puedeMover
    }

    method puedeAtacar() {
        return puedeAtacar
    }

    method siguienteFrame(frame, personaje) {
        if(frame.noHaySiguienteFrame(maxFramesEstado)) {
            personaje.estado(normal)
        }
    }
}

var normal = new Estado(nombre = "normal", puedeMover = true, puedeAtacar = true, maxFramesEstado = 6)

var ataque = new Estado(nombre = "ataque", puedeMover = false, puedeAtacar = false, maxFramesEstado = 8)

var danio = new Estado(nombre = "danio", puedeMover = false, puedeAtacar = false, maxFramesEstado = 6)