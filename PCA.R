m <- prcomp(a, center = TRUE, scale.=TRUE)
summary(m)

install.packages('devtools')
library(devtools)
install_github("kassambara/factoextra")
library('factoextra')

b <- select(gun,'date', 'n_injured', 'state', 'city_or_county', 
            'n_killed', 
            'latitude', 'longitude', 
            'n_guns_involved', 'participant_age', 
            'participant_age_group', 'participant_gender', 
            'participant_status', 
            'participant_type', 'state_house_district', 
            'state_senate_district', 'region')

fviz_pca_ind(m , geom.ind = 'point', col.ind = as.factor(b$region), addEllipses = TRUE, 
             legend.tittle = "Groups")

fviz_pca_biplot(m , geom.ind = 'point', geom.var = c('arrow', 'text'), col.ind = as.factor(b$region), addEllipses = TRUE, 
             legend.tittle = "Groups")
