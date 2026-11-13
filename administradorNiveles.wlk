import mapa.*


object administradorNiveles {
    const niveles = [nivel1]
    var indiceActual = 0

    method nivelActual() {
        return niveles.get(indiceActual)
    }

    method avanzarNivel() {
        if (self.haySiguienteNivel()) {
            indiceActual += 1
        }
    }

    method haySiguienteNivel() {
        return indiceActual < niveles.size() - 1
    }

    method reiniciar() {
        indiceActual = 0
    }
}