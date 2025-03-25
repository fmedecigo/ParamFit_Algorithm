# ParamFit Algorithm  

ParamFit is an algorithm for outline fitting based on a parametric function designed to represent simple closed curves. It employs the Levenberg-Marquardt method to optimize fitting parameters, ensuring high accuracy across various applications.  

### 🚀 Features  
- **Closed curve fitting** using a flexible parametric function.  
- **Optimization with Levenberg-Marquardt**, leveraging well-defined initial conditions.  
- **Fitting validation** through metrics such as Jaccard index, \( R^2 \), RMSE, and residual error.  
- **Applicable to different domains**, including seed outlines, diatoms, and geometric curves.  

### 📂 Contents  
- MATLAB code for parametric fitting.  
- Implementation of the optimization algorithm.  
- Test data for different applications.  

## 🛠 Reproduction Instructions  

The functions and scripts included in this repository are necessary to reproduce the results presented in this work. Specifically, the main executable scripts are:  

1. **`diatomsfitting.m`**  
2. **`seedsfitting.m`**  
3. **`planarcurvesfitting.m`**  

The **`.csv`** and **`.xlsx`** files containing the point sets for each application described in this work can be found in their corresponding folders within the repository. To recreate the results, these files must be downloaded, and their paths must be properly updated in the scripts.  

For planar curves, the **`PlanarCurves`** folder contains additional scripts to generate point sets for various parametric curves.  

If you wish to apply the algorithm to a different image, the **`outlineextract`** script is available to extract the object's outline.  

⚠ **Ensure that all required functions are downloaded into the same directory before running the scripts.**  

## Related Resources  

The **PointNet model**, trained using the CurveML benchmark, is used as a comparison baseline against the **ParamFit** algorithm. The model is available at:  
🔗 [CurveML Repository](https://gitlab.com/4ndr3aR/CurveML)  

The **dataset with diatom images**, used in the evaluation, is available at:  
📂 [ADIAC Dataset](https://websites.rbge.org.uk/ADIAC/pubdat/downloads/)  


## 👥 Authors & Affiliation  

**Eng. Felipe A. Medécigo-Cabriales**  ~ ![ORCID](https://img.shields.io/badge/ORCID-0009--0005--0619--3290-green?logo=orcid)  
**M.Sc. Francisco Alejandro Alaffita-Hernández**  ~ ![ORCID](https://img.shields.io/badge/ORCID-0000--0002--7971--6356-green?logo=orcid)  
**Ph.D. Beatris Adriana Escobedo-Trujillo**  ~ ![ORCID](https://img.shields.io/badge/ORCID-0000--0002--8937--3019-green?logo=orcid)  

🔬 **Affiliation:**  
 **Maestría en Ciencias en Tecnología Energética (MaCTE)**  
 **Centro de Investigación en Recursos Energéticos y Sustentables (CIRES)**  
 **Universidad Veracruzana (UV)**  


