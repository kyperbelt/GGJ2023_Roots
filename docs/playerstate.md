```mermaid
stateDiagram-v2
    [*] --> Idle
    Idle --> Moving: Input
    Idle --> Rooting
    Idle --> Falling
    Rooting --> Idle
    Rooting --> Flourishing 
    Rooting --> Falling
    Falling --> Idle
    Moving --> Idle 
    Moving --> Falling
```