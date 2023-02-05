```mermaid
stateDiagram-v2
    [*] --> Idle
    Idle --> Moving
    Idle --> Rooting
    Idle --> Falling
    Idle --> Grappling 
    Grappling --> Idle
    Grappling --> Falling
    Rooting --> Idle
    Rooting --> Flourishing 
    Rooting --> Falling
    Falling --> Idle
    Moving --> Idle 
    Moving --> Falling
    Moving --> Grappling
    Flourishing --> Idle
```