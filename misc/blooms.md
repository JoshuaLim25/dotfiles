
# The Back and Forth
---
> "How does this work under the hood?"
|-> "Why does it work that particular way? Why not this way?"
|-> "What happens when..."
  |-> For instance, "what happens when unexpected/abnormal input is received?"
|-> "Why?"

## Considering abstractions
- With any abstraction, the two natural followup questions should be centered around the tradeoffs:
> **"What do you gain by using this?"**
> **"What is this costing you?"**
- E.g., iterators. Why iterators over indices?
- What is iteration? "Go through a thing (collection) one-by-one." Iterators are a thing that goes through the thing (i.e., they automate the process for you).
- Abstraction of use: you just want to iterate some elements, you don't care about how to do it
- Performance wins
- Decouples an algorithm from the data it operates on. This means that as long as we know how to get something from the iterator, we can operate on iterators themselves as a "proxy" or a pointer to get the data one by one, and then run algorithms on that data. 
- "it will maintain a pointer to the current node and advance it [good stuff about efficiency]" - yeah, i don't get why people have trouble understanding the concept of iterators. they're conceptually just a superset of pointers. why compute the offset of some element over and over again when you can just cache a pointer to it? well, that's what iterators do too.


## 1. Remember (Recall)
---
|-> "What is `<topic>`?"
|-> "What are the key characteristics of `<topic>`?"
|-> "When is `<topic>` used?"


## 2. Understand (Explain Concepts)
---
|-> "Why is `<topic>` needed/used?"
|-> "What are the underlying principles of `<topic>`?"
|-> "How does `<topic>` relate to similar concepts?"


## 3. Apply (Use in Context)
---
|-> "What happens when..."
|-> "How does it work?"
|-> "How is `<topic>` implemented in practice?"
|-> "Can `<topic>` be adapted to solve this problem?"
|-> "What are the specific limitations of `<topic>`?"
  |-> "Can `<topic>` scale efficiently with increased data or users?"
  |-> "What optimizations are possible for `<topic>` in specific scenarios?"
  |-> "How does `<topic>` behave under stress or in failure scenarios?" 
  |-> "When should `<topic>` not be used? Why?"


#### 3.5. Testing/Debugging
|-> "What are common pitfalls or bugs when implementing `<topic>`?"
|-> "How can errors in `<topic>` be detected or diagnosed?"
|-> "What testing strategies are effective for verifying `<topic>`?"

#### 3.5. Perf/Optimization
|-> "What are the performance bottlenecks in `<topic>`?"
|-> "How can `<topic>` be optimized for speed, memory usage, or resource efficiency?"


## 4. Analyzing (Break Down Information)
---
|-> "What are the main components (the crux) of `<topic>`?"
|-> "What assumptions are made in `<topic>`?" -> "Why?"
|-> "Why is `<topic>` relevant in this context?"
|-> "What is the significance of `<topic>` in this system or process?"


# 5. Evaluating (Assess and Compare)
---
|-> "Why use `<topic>` instead of `<alternative>`?"
|-> "What are the tradeoffs of `<topic>`?"
|-> "What do you stand to gain or lose by using `<topic>`?"
|-> "How helpful is `<topic>` in solving the problem compared to `<alternative>`?"


# 6. Creating (Synthesize New Understanding)
---
|-> "How can `<topic>` be extended or modified to solve a new problem?"
|-> "What new solutions can be developed by combining `<topic>` with `<other concept>`?"
|-> "How can `<topic>` be adapted to fit a specific requirement or constraint?"
  |-> "What novel applications can be imagined by rethinking `<topic>` from a different perspective?"
  |-> "What unexplored areas could `<topic>` address in CS?"


---




# Problem Solving
---

## 1. Understand the Problem
|-> "*Have I accounted for everything*?"


## 2. Devise a Plan
- establish connections between givens to obtain the idea of the solution



## 3. Execute Your Plan



## 4. Analyze and Refine Your Solution




