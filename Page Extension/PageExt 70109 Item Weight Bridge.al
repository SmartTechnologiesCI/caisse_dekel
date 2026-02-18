pageextension 70109 "Item Weight Bridge" extends "Item Weight Bridge"
{
    layout
    {
        addafter("Ticket Planteur")
        {
            field(Date_Paiement; Date_Paiement)
            {
                ApplicationArea = All;
            }
            field(NumDocExten; NumDocExten)
            {
                ApplicationArea = All;
            }
            field(NumeroDocTransport; NumeroDocTransport)
            {

            }
        }
        addafter(valide)
        {
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