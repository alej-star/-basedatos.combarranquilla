from catalogo_simple import SimpleCatalogWindow



 

class CategoriasWindow(SimpleCatalogWindow):

    def __init__(self, parent, on_change=None):

        super().__init__(parent, "categorias", "Gestión de Categorías")