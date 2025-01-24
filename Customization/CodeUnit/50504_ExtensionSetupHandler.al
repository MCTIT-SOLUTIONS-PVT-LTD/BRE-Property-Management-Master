codeunit 50504 "Extension Setup Handler"
{
    // Subtype = Install;
    // trigger OnInstallAppPerCompany()
    // var
    //     ExtensionSetup: Record "Module Setup";
    // begin
    //     // Add Property Management
    //     if not ExtensionSetup.Get('PM') then begin
    //         ExtensionSetup.Init();
    //         ExtensionSetup."Extension Name" := 'PM';
    //         ExtensionSetup."Is Active" := true;
    //         ExtensionSetup.Insert();
    //     end;

    //     // Add Property Sales
    //     if not ExtensionSetup.Get('PS') then begin
    //         ExtensionSetup.Init();
    //         ExtensionSetup."Extension Name" := 'PS';
    //         ExtensionSetup."Is Active" := true;
    //         ExtensionSetup.Insert();
    //     end;

    //     Message('Extensions have been configured.');
    // end;

    SingleInstance = true;


}