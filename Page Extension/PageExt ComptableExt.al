pageextension 70100 "Acountant Role center" extends 9027
{
    layout
    {
        // Add changes to page layout here

    }

    actions
    {
        // Add changes to page actions here
        addlast(processing)
        {
            action("&Etat liste des fournisseurs")
            {
                Caption = 'fournisseurs à payer';
                RunObject = report 70012;
            }
        }
    }

    var
        myInt: Integer;
}