pageextension 70106 "User Setup" extends "User Setup"
{
    layout
    {
        addafter("User ID")
        {
            field(EnAttentePaiement; EnAttentePaiement)
            {
                ApplicationArea = All;
            }
            field(AutorisationAnnulation; AutorisationAnnulation)
            {
                ApplicationArea = All;
            }
            field(Annule; REC.Annule)
            {
                ApplicationArea = All;
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