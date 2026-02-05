pageextension 70171 "Whse. Basic RoleSI" extends "Whse. Basic RoleSI"
{
    layout
    {
        addafter(Control1900724808)
        {
            group(ValidationFournisseurs)
            {
                Caption = 'Validation Fournisseur';
                part(ValidationFournisseur; ValidationFournisseur)
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}