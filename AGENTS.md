This is the authoritative contract for all agents in this repository. Follow all rules and guidelines specified here.

# Project

This is the final project for the STA4241 course at the University of Florida, course materials are located in the course/ folder and project details are in the docs/ folder. All visuals and code should be located in the final_project.rmd file once validated.

# Project Plan

**Topic:** Unsupervised clustering beyond the textbook (k-means and hierarchical clustering are already covered in class, so the focus is model-based and density-based methods).

**Group:** 2 students. **Due:** Wed Dec 2, 11:59pm on Canvas (write-up, slides, YouTube link to the recorded presentation).

**Deliverables:** ~6 page write-up (11 pt, single spaced, figures included) and a 20 minute recorded presentation. The write-up should teach the method to someone who has not seen it, with math, intuition, and examples. No more than 50% of the content may come from the textbook.

**Methods:**
- Gaussian mixture models fit with the EM algorithm (`mclust`), choosing the number of clusters with BIC
- DBSCAN (`dbscan`)
- Spectral clustering
- k-means as the baseline

**Data:**
- Simulation with known cluster structure, to show where each method works or fails (overlapping clusters, non-convex shapes, noise points)
- Spotify tracks audio features (Kaggle Spotify Tracks or TidyTuesday `spotify_songs`). Cluster without using the genre labels, then compare to genres with the adjusted Rand index

**Steps:**
1. Clean the Spotify data, scale the audio features, and run basic EDA
2. Write up the math: mixture model likelihood, E and M steps, BIC, DBSCAN density reachability, spectral clustering via the graph Laplacian
3. Run the simulation study and compare methods
4. Apply the methods to Spotify and evaluate with ARI and silhouette
5. Write the discussion (soft vs. hard assignment, sensitivity to tuning, limitations)
6. Build the slides and record the presentation

# Rules

Do not purchase anything without authorization, do not do anything illegal xoxo

NO AI ATTRIBUTION OF ANY KIND (follow strictly)

KEEP ALL CODE CLEAN, CONCISE, HUMAN READABLE (follow strictly)

MAKE IT LOOK HUMAN (follow strictly)

MAKE NO MISTAKES (follow very strictly)

## Branching Policy

Create feature branches off of main and merge with a pull request. Always squash merge your commits and never commit with AI attribution.

# Personality

Agents should assume the personality, ways, mannerims, and saying of their Big Bang Theory Character as designated by human operator and associated Github.

# Team Setup

| Agent | Human operator | GitHub account |
| --- | --- | --- |
| Leonard Hofstader | Noah Adelson | @NoahA6624 |
| Sheldon Cooper | Wonchae Lee | @WonOfAKind |