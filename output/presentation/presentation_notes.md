# Clustering Beyond K-means

Use the slide deck in full-screen mode and keep these notes beside it. The timings are elapsed targets for a 20-minute recording. Noah covers slides 1–6 and Wonchae covers slides 7–13.

## Noah · 0:00–10:35

### 1 · Clustering Beyond K-means · 0:00–0:40

Introduce both presenters and the question. If you give several algorithms the same observations, what makes them draw different groups? Explain that the comparison starts with cases where we know the generating labels. Then it looks at how much structure from an audio-only fit corresponds to Spotify playlist genres.

### 2 · What counts as a cluster? · 0:40–2:15

Walk across the three panels. In the left panel two elliptical clouds overlap. In the middle, the two colors wrap around each other. On the right, the gray points were generated from a uniform background distribution. Some happen to land inside the blobs.

Point to the moons and sketch a line with the cursor where a boundary between two fitted centers might fall. Explain why the line would group the wrong parts of the two curves. For two centers that boundary is the perpendicular bisector. For more centers the partition consists of convex regions, which is useful for compact groups. We use 25 starts for each candidate count and select the count by average silhouette.

### 3 · A Gaussian mixture models overlapping groups · 2:15–4:05

Describe the model as a two-stage draw. First choose a latent component using the mixing weights, then draw an observation from its multivariate normal distribution. In two dimensions an equal-density contour looks like an ellipse. Point out that shifting the mean moves the ellipse and changing the covariance changes its shape and angle.

Explain the observed likelihood. We see the point but usually cannot tell which component generated it, so its observed density adds the contributions from every component. A point in the overlap can have a high likelihood under both components. This makes component probabilities more informative than just recording the larger of the two.

### 4 · EM estimates the mixture and BIC selects a model · 4:05–6:15

Work through an example where two components contribute 0.36 and 0.12 to the density. Divide by their sum to get responsibilities of 0.75 and 0.25. A hard assignment goes to the first component. During estimation the same observation contributes fractional weight to both.

In the M step, sum the weights to get an effective sample size. Each mean is a weighted average. Covariance uses weighted deviations from the updated mean, with restrictions depending on the chosen family. Alternate the steps to improve the observed-data likelihood. Different initial values can converge to different solutions.

Read BIC as fit minus a complexity penalty. We consider one through eight components and six covariance families. Explain that a mixture can use several ellipses for one curved group. A good density approximation may therefore give a different component count from the number of groups a person sees.

### 5 · DBSCAN follows chains of dense neighborhoods · 6:15–8:20

Imagine a radius around a track point in standardized feature space. The point becomes a core if its neighborhood contains enough observations. A nearby point can be accepted as border even if its own neighborhood is thin. A chain travels through the core points, so a border point can be included at the end but cannot extend the chain.

Follow the first moon with the cursor in your mind. Several short links can join observations across the length of the arc. If the radius is too short, gaps within the arc split it. If the radius is too long, a chain can also bridge across to the other arc. Explain how we choose the starting radius from the distribution of neighbor distances and why a single radius can be difficult for groups of unequal density.

### 6 · Spectral clustering uses a graph embedding · 8:20–10:35

Each observation is a vertex. A pair is joined if either is among the other's 15 nearest neighbors. We weight those links using a Gaussian function of their original distance. The degree measures total connection strength for each vertex. Explain that the normalization puts the connections in the context of the strength at their endpoints.

For intuition, imagine smoothly coloring strongly linked vertices. Members of a nearly separate group can have similar values in the first few eigenvectors. The eigengap rule looks for a jump after the estimated number of meaningful eigenvectors. Use those eigenvectors as coordinates, normalize each row, and then run k-means in the new coordinates. The graph and the choice of K both matter. Hand off to Wonchae for how those choices behaved.

## Wonchae · 10:35–20:00

### 7 · Simulation design and scoring · 10:35–11:40

We repeated each setup 30 times and standardized the two features inside each run. The same points went to every method. ARI uses pairs and gives the same score if we swap the display colors. Silhouette uses distances, so it answers a different question about compactness. Point out that DBSCAN's silhouette uses only the assigned points. This is why the assigned percentage appears next to silhouette in the Spotify table.

### 8 · Shape and noise change which method succeeds · 11:40–13:10

Read across the mixture row and then compare it to k-means on the overlapping ellipses. The mixture can adapt to the covariance orientations, so the two algorithms have different boundaries. Even a good fit cannot recover every generating label in a region where both distributions have support.

On the noisy blobs we can separately ask how many of the uniform draws DBSCAN flags. Its ARI also rewards recovering the three blobs. A background draw landing inside a blob can be hard to identify. Mixtures, spectral clustering, and k-means assign every point, which influences how their results compare to a truth partition containing a noise label. In the moons column, highlight that the original settings did not cleanly recover the two arcs.

### 9 · The spectral embedding separates the two moons · 13:10–15:00

Spend a moment on the truth panel. Trace the upper arc. On the k-means panel, trace where the upper arc changes colors. The algorithm has the right count in this experiment but still draws a straight boundary. Then trace the spectral partition to see how links along the arc change the representation.

Both methods get exactly two groups here. We used that known count only for this control, so its result tests the representation rather than automatic cluster selection. Compare the ARI values and the two silhouettes. Points at opposite ends of one moon are farther apart than a silhouette expects from a compact cluster. This is a concrete case in which the distance score favors the less faithful answer.

### 10 · Spotify audio features and playlist genres · 15:00–16:25

Explain the unit of observation. The source has one row per playlist appearance, so we kept one audio row per track ID and drew 2,500 unique tracks. The ten inputs include energy, loudness, tempo, and duration. Z-scoring makes minutes and audio feature scores comparable in scale, but correlated features can still give some aspects of sound more weight.

We fit every track without reference labels. Afterward, we recovered a genre only when the recorded playlist genre agreed across appearances. Point across the PCA panels using their shared scales. Many tracks occupy similar regions. The projection illustrates the overlap while the original fit uses all ten features.

### 11 · Audio clusters showed weak genre agreement · 16:25–17:55

Start with the ARI column. The best agreement is still small, so none of the four fitted partitions matches playlist genres closely for this sample. The mixture can be very sure of its own component assignments while those assignments cross the genre categories. Confidence refers to what the fitted density model believes.

Move to silhouette. Spectral clustering produced a relatively more compact score for this data representation, but that does not require its groups to have higher genre agreement. DBSCAN has no silhouette here because it produced one cluster and some noise. Its assigned percentage tells us how much of the sample was in that cluster.

### 12 · Sensitivity and takeaways · 17:55–19:40

Walk through the DBSCAN range. Moving the radius changes which tracks are rejected, while the remaining tracks still form a single broad cluster at the settings we tried. A different distance or a method that allows density to vary across regions might lead to a different partition. Spectral clustering's ARI was similarly low at the three neighbor counts, which says something about this range on this sample.

Return to the two original questions. Geometry helped predict how the algorithms would behave on known data, but parameter selection still mattered. In Spotify, weak ARI is evidence about agreement with playlist labels for these selected audio features. Genre can also reflect curation, conventions, and information outside those features.

### 13 · References · 19:40–20:00

Leave the sources on screen and close with the distinction between recovering generating labels in a simulation and comparing an audio partition to playlist genres.

## Recording handoff

Record the two-person presentation locally in Zoom. Play the recording back to check both voices, slide readability, and the approximately 20-minute runtime. Upload it to YouTube as **Unlisted** and verify the link in a signed-out browser. Submit the write-up, slides, and recording link together in Canvas by Wednesday, December 2, 2026, at 11:59 p.m. Eastern.
