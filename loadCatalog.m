function [] = loadCatalog()
    %LOADCATALOG loads the bearing catalog from file
    %   catalog must be saved as "Bearings.xlsx" in same folder as this
    %   program. must have columns of type, ID, OD, width, dynamicLoad,
    %   staticLoad, referenceSpeed, limitingSpeed, designation

    global catalog;
    file = "Bearings.xlsx";
    opts = detectImportOptions(file)
    catalog = readtable(file,opts)

end

