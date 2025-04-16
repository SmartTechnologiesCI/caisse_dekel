page 70109 "Caisse cue"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = 9055;

    layout
    {
        area(Content)
        {
            cuegroup(General)
            {
                Caption = 'Tickets non facturés';
                field("Ticket du jour"; rec."Ticket du jour")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = true;
                    Caption = 'Ticket(s) du jour';
                    trigger OnDrillDown()
                    var
                        factureJour: Record "Purch. Inv. Header";
                    begin
                        factureJour.setFilter("Order Date", '=%1', WorkDate());
                        factureJour.SetRange(Closed, false);
                        factureJour.FindFirst();
                        Page.RunModal(Page::"Posted Purchase Invoices", factureJour);
                    end;
                }
                field("Ticke Anterieur non paye"; REC."Ticke Anterieur non paye")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        factureJour: Record "Purch. Inv. Header";
                    begin
                        factureJour.SetFilter("Order Date", '<%1', WorkDate);
                        factureJour.SetRange(Closed, false);
                        factureJour.FindFirst();
                        Page.RunModal(Page::"Posted Purchase Invoices", factureJour);
                    end;
                }
            }
            cuegroup("Ticket(s) facturé(s)")
            {
                field("Ticket(s) Facturé(s) du jour";"Ticket(s) Facturé(s) du jour")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = true;
                    Caption = 'Ticket(s) Facturé(s) du jour"';
                    trigger OnDrillDown()
                    var
                        factureJour: Record "Purch. Inv. Header";
                    begin
                        factureJour.setFilter("Order Date", '=%1', WorkDate());
                        factureJour.SetRange(Closed, true);
                        factureJour.FindFirst();
                        Page.RunModal(Page::"Posted Purchase Invoices", factureJour);
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetFilter("date filter 3", '=%', WorkDate());
        SetFilter("date filter 2", '<=%', WorkDate());
    end;
}