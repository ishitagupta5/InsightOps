flowchart LR
    subgraph Cluster
        Loki[(Loki)]
        Prometheus[(Prometheus)]
        EventWatcher[Event-Watcher]
        RuleEngine[Rule Engine]
        LLM[LLM Summarizer API]
    end
    Pods((AI/ML Pods)) --> Prometheus
    Pods --> Loki
    Pods --> EventWatcher
    EventWatcher -->|events| Loki
    Loki & Prometheus --> RuleEngine
    RuleEngine -->|log chunks + tags| LLM
    LLM -->|summary| CLI[CLI / Dashboard]
