function startUnitTests()
    %adding path to search functions
    addpath(genpath(fullfile(pwd,'UnitTests/_matlab_xunit_3_1_1/')))
    %setting up path to folder with tests
    suite = TestSuite.fromName('UnitTests');
    %launching all tests
    suite.run
end