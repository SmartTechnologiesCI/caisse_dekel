pageextension 70014 Teams extends 5105
{
    layout
    {
        // Add changes to page layout here
        modify("Next Task Date")
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter(Salespeople)
        {
            action("Associer tache")
            {
                Caption = 'Tâche';
                PromotedCategory = Process;
                Promoted = true;
                PromotedIsBig = true;
                Image = Task;
                RunObject = page "Objectif Commercial card";
                /* RunPageLink = Groupe = field(Code); */
                RunPageMode = Create;




            }
            action(Peseur)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Peseur';
                Image = PersonInCharge;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page Peseur;
                RunPageLink = "Team Code" = FIELD(Code);

            }


        }

    }

    var
        myInt: Integer;
}