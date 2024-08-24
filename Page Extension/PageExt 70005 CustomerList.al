pageextension 70005 "CustList" extends "Customer List"
{
    layout
    {

        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify(Contact)
        {
            Visible = false;
        }
        modify("Phone No.")
        {
            Visible = false;
        }
        addafter("Phone No.")
        {
            field("Mobile Phone No."; rec."Mobile Phone No.")
            {

            }
            field("Crédits"; rec."Crédits")
            {

            }
            field("Dépôts"; rec."Dépôts")
            {

            }

        }
        modify("Balance (LCY)")
        {
            Visible = false;
        }

        modify("Balance Due (LCY)")
        {
            Visible = false;
        }

        modify("Sales (LCY)")
        {
            Visible = false;
        }

        modify("Payments (LCY)")
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
        addfirst(processing)
        {
            action("Modifier bonus")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                Image = Refresh;

                trigger OnAction()
                var
                    myInt: Integer;
                    clients: Record Customer;


                begin
                    clients.Reset();
                    CurrPage.SetSelectionFilter(clients);
                    if clients.FindFirst() then begin
                        repeat
                            clients."do epargne" := not clients."do epargne";
                            clients.Modify();
                        until clients.next = 0;
                    end;

                    Message('Les clients selectionnés pouront obtenir un bonus');
                end;
            }
            action("clear sales person code")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                Image = ClearLog;

                trigger OnAction()
                var
                    myInt: Integer;
                    clients: Record Customer;


                begin
                    clients.Reset();
                    CurrPage.SetSelectionFilter(clients);
                    if clients.FindFirst() then begin
                        repeat
                            clear(clients."Salesperson Code");
                            clients.Modify();
                        until clients.next = 0;
                    end;

                    Message('Les clients selectionnés pouront obtenir un bonus');
                end;
            }
        }
    }

    var
        myInt: Integer;
}