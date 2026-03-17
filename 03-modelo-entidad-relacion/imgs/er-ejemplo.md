```mermaid
erDiagram
    CLIENTE
    PEDIDO
    PRODUCTO
    PEDIDO_PRODUCTO

    CLIENTE ||--o{ PEDIDO : realiza
    PEDIDO ||--o{ PEDIDO_PRODUCTO : contiene
    PRODUCTO ||--o{ PEDIDO_PRODUCTO : incluido_en
```
