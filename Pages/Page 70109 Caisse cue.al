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
                Caption = 'Tickets non payés du jour';
                field("Ticket du jour"; rec."Ticket du jour")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = true;
                    Caption = 'Ticket(s) Transporteur du jour non payés';
                    trigger OnDrillDown()
                    var
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        ItemWeighBridge.setFilter("Date validation", '=%1', WorkDate());
                        ItemWeighBridge.SetRange(valide, true);
                        ItemWeighBridge.SetRange("Statut paiement", false);
                        ItemWeighBridge.SetRange("Type opération", 'ACHAT DIRECT');
                        ItemWeighBridge.FindFirst();
                        Page.RunModal(Page::"Ticket Caisse", ItemWeighBridge);
                    end;
                }
                field("Ticket du jour Planteur"; rec."Ticket du jour Planteur")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = true;
                    Caption = 'Ticket(s) Planteur du jour non payés';
                    trigger OnDrillDown()
                    var
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        ItemWeighBridge.setFilter("Date validation", '=%1', WorkDate());
                        ItemWeighBridge.SetRange(valide, true);
                        ItemWeighBridge.SetRange("Statut paiement Planteur", false);
                        ItemWeighBridge.FindFirst();
                        Page.RunModal(Page::"Ticket Caisse", ItemWeighBridge);
                    end;
                }
                field("Ticke Anterieur non paye"; REC."Ticke Anterieur non paye")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Tickets Transporteurs antérieurs non payés';

                    trigger OnDrillDown()
                    var
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        ItemWeighBridge.SetFilter("Weighing 1 Date", '<%1', WorkDate);
                        ItemWeighBridge.SetRange(valide, true);
                        ItemWeighBridge.SetRange("Statut paiement", false);
                        ItemWeighBridge.SetRange("Type opération", 'ACHAT DIRECT');
                        ItemWeighBridge.FindFirst();
                        Page.RunModal(Page::"Ticket Caisse", ItemWeighBridge);
                    end;
                }
                field("Ticke Anterieur non paye Planteur"; "Ticke Anterieur non paye Planteur")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Tickets Planteurs antérieurs non payés ';
                    trigger OnDrillDown()
                    var
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        ItemWeighBridge.SetFilter("Weighing 1 Date", '<%1', WorkDate());
                        ItemWeighBridge.SetRange(valide, true);
                        ItemWeighBridge.SetRange("Statut paiement Planteur", false);
                        ItemWeighBridge.FindFirst();
                        Page.RunModal(Page::"Ticket Caisse", ItemWeighBridge);
                    end;
                }
                //FnGeek*********15_11_25
                field("Ticket du jour non payés"; "Ticket du jour non payés")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = true;
                    Caption = 'Ticket(s) du jour non payés';
                    trigger OnDrillDown()
                    var
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        ItemWeighBridge.setFilter("Date validation", '=%1', WorkDate());
                        ItemWeighBridge.SetRange(valide, true);
                        ItemWeighBridge.SetRange(Statut_Total_Paiement, false);
                        ItemWeighBridge.FindFirst();
                        Page.RunModal(Page::"Ticket Caisse", ItemWeighBridge);
                    end;
                }
                field("Ticket non payés"; "Ticket non  payés")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = true;
                    Importance = Promoted;
                    Style = Attention;
                    Caption = 'Ticket(s) non payés';
                    trigger OnDrillDown()
                    var
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        // ItemWeighBridge.setFilter("Date validation", '=%1', WorkDate());
                        ItemWeighBridge.SetRange(valide, true);
                        ItemWeighBridge.SetRange(Statut_Total_Paiement, false);
                        ItemWeighBridge.FindFirst();
                        Page.RunModal(Page::"Ticket Caisse", ItemWeighBridge);
                    end;
                }
                field("Ticket En attente paiement"; "Ticket En attente paiement")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = true;
                    Importance = Promoted;
                    Style = Attention;
                    Caption = 'Ticket(s) en attente paiement';
                    trigger OnDrillDown()
                    var
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        // ItemWeighBridge.setFilter("Date validation", '=%1', WorkDate());
                        ItemWeighBridge.SetRange(valide, true);
                        ItemWeighBridge.SetRange(En_Attente_Paiement, true);
                        ItemWeighBridge.FindFirst();
                        Page.RunModal(Page::"Ticket Caisse", ItemWeighBridge);
                    end;
                }

                //FnGeek*********
            }
            cuegroup("Ticket(s) facturé(s)")
            {
                Caption = 'Tickets payés jour';
                field("Ticket(s) Facturé(s) du jour"; "Ticket(s) Facturé(s) du jour")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = true;

                    Caption = 'Ticket(s) Transporteur du jour payés';
                    trigger OnDrillDown()
                    var
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        ItemWeighBridge.setFilter("Date validation", '=%1', WorkDate());
                        ItemWeighBridge.SetRange("Statut paiement", true);
                        ItemWeighBridge.SetRange("Type opération", 'ACHAT DIRECT');
                        ItemWeighBridge.FindFirst();
                        Page.RunModal(Page::"Ticket Caisse", ItemWeighBridge);
                    end;
                }
                field("Ticket(s) Facturé(s) du jour Planteur"; "Ticket(s) Facturé(s) du jour Planteur")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = true;

                    Caption = 'Ticket(s) Planteur du jour payés"';
                    trigger OnDrillDown()
                    var
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        ItemWeighBridge.setFilter("Date validation", '=%1', WorkDate());
                        ItemWeighBridge.SetRange("Statut paiement Planteur", true);
                        ItemWeighBridge.FindFirst();
                        Page.RunModal(Page::"Ticket Caisse", ItemWeighBridge);
                    end;
                }

            }
            cuegroup("Tickets payés")
            {
                field("Ticket(s) Facturé(s) Planteur"; "Ticket(s) Facturé(s) Planteur")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = true;

                    Caption = 'Ticket(s) Planteurs payés"';
                    trigger OnDrillDown()
                    var
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        // ItemWeighBridge.setFilter("Date validation", '=%1', WorkDate());
                        ItemWeighBridge.SetRange("Statut paiement Planteur", true);
                        ItemWeighBridge.FindFirst();
                        Page.RunModal(Page::"Ticket Caisse", ItemWeighBridge);
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
        SetFilter("date filter 3", '=%1', WorkDate());
        SetFilter("date filter 2", '=%1', WorkDate());
        SetFilter("Date filter 4", '<%1', WorkDate());
    end;
}