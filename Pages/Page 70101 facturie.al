

page 70101 "Facturier role center"
{
    PageType = RoleCenter;
    Caption = 'Facturié';

    layout
    {
        area(RoleCenter)
        {

            part("Headline"; 70052)
            {

            }
            part("Activités de facture"; 70102)
            {
                Caption = 'Activités de facture';
                ApplicationArea = All;
            }

            part("La Tulipe Food"; 70093)
            {
                ApplicationArea = All;
            }

            part(inbox; "Report Inbox Part")
            {

            }


        }
    }
     actions
    {
        area(Processing)
        {

            action("Factures validées")
            {
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Report;
                RunObject = report 70047;
                
                
            }
        }
    }
}